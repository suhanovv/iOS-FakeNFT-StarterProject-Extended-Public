//
//  CollectionViewModel.swift
//  iOS-FakeNFT-Extended
//
//  Created by Diana Viter on 10.12.2025.
//

import SwiftUI

@MainActor
final class CollectionViewModel: ObservableObject {

    // MARK: - External dependencies
    
    private let nftService: NftService

    // MARK: - Input
    
    let collection: CollectionDTO

    // MARK: - State
    
    @Published var nfts: [Nft] = []
    @Published var state: ScreenState = .initial

    // MARK: - Init
    
    init(
        collection: CollectionDTO,
        nftService: NftService = MockNftService()
    ) {
        self.collection = collection
        self.nftService = nftService
    }

    // MARK: - Public methods
    
    func load() async {
        state = .loading

        nfts = MockData.nfts.filter { collection.nftIds.contains($0.id) }

        state = .loaded
    }
}
