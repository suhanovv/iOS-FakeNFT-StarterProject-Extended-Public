//
//  CollectionViewModel.swift
//  iOS-FakeNFT-Extended
//
//  Created by Diana Viter on 10.12.2025.
//

import SwiftUI

@MainActor
final class CollectionViewModel: ObservableObject {
    
    // MARK: - State
    
    @Published var nfts: [Nft] = []
    @Published var state: ScreenState = .initial
    @Published private(set) var collection: CollectionDTO?
    @Published private(set) var cartNftIds: Set<String> = []
    
    // MARK: - External dependencies
    
    private let collectionId: String
    private let collectionService: CollectionServiceProtocol
    private let orderService: OrderServiceProtocol?
    
    // MARK: - Init
    
    init(
        collectionId: String,
        collectionService: CollectionServiceProtocol,
        orderService: OrderServiceProtocol? = nil
    ) {
        self.collectionId = collectionId
        self.collectionService = collectionService
        self.orderService = orderService
    }
    
    // MARK: - Public methods
    
    func load() async {
        guard collection == nil else { return }   
        state = .loading
        do {
            let collection = try await collectionService.fetchCollection(id: collectionId)
            self.collection = collection
            self.nfts = try await collectionService.loadNfts(ids: collection.nftIds)
            await loadCartState()
            state = .loaded
        } catch {
            state = .error(error.localizedDescription)
        }
    }
    
    func toggleCart(nftId: String) async {
        guard let orderService else { return }
        
        do {
            if cartNftIds.contains(nftId) {
                _ = try await orderService.removeFromCartNft(nftId)
                cartNftIds.remove(nftId)
            } else {
                _ = try await orderService.addToCartNft(nftId)
                cartNftIds.insert(nftId)
            }
        } catch {
            // Silent fail - cart state will be reloaded on next screen appearance
        }
    }
    
    func isInCart(_ nftId: String) -> Bool {
        cartNftIds.contains(nftId)
    }
    
    // MARK: - Private methods
    
    private func loadCartState() async {
        guard let orderService else { return }
        
        do {
            let order = try await orderService.getOrder()
            cartNftIds = Set(order.nfts)
        } catch {
            // Silent fail - cart state is optional
        }
    }
}
