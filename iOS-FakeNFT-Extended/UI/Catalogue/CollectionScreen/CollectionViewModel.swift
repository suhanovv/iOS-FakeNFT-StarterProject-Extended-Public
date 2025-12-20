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
    
    // MARK: - External dependencies
    
    private let collectionId: String
    private let collectionService: CollectionServiceProtocol
    
    // MARK: - Init
    
    init(collectionId: String, collectionService: CollectionServiceProtocol) {
        self.collectionId = collectionId
        self.collectionService = collectionService
    }
    
    // MARK: - Public methods
    
    func load() async {
        state = .loading
        do {
            let collection = try await collectionService.fetchCollection(id: collectionId)
            self.collection = collection
            self.nfts = try await collectionService.loadNfts(ids: collection.nftIds)
            state = .loaded
        } catch {
            state = .error(error.localizedDescription)
        }
    }
}
