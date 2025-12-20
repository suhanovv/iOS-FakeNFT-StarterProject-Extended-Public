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
    
    // MARK: - Input
    
    let collection: CollectionDTO

    // MARK: - External dependencies
    
    private let collectionService: CollectionServiceProtocol

    // MARK: - Init

    init(
        collection: CollectionDTO,
        collectionService: CollectionServiceProtocol
    ) {
        self.collection = collection
        self.collectionService = collectionService
    }

    // MARK: - Public methods
    
    func load() async {
        state = .loading
        do {
            nfts = try await collectionService.loadNfts(ids: collection.nftIds)
            state = .loaded
        } catch {
            state = .error(error.localizedDescription)
        }
    }
}
