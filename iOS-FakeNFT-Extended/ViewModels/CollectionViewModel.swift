//
//  CollectionViewModel.swift
//  iOS-FakeNFT-Extended
//
//  Created by Diana Viter on 10.12.2025.
//

import SwiftUI

final class CollectionViewModel: ObservableObject {

    // MARK: - External dependencies
    
    private let nftService: NftService?

    // MARK: - Input
    
    let collection: CollectionDTO

    // MARK: - State
    
    @Published var nfts: [Nft] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    // MARK: - Init
    
    init(
        collection: CollectionDTO,
        nftService: NftService? = nil
    ) {
        self.collection = collection
        self.nftService = nftService
    }

    // MARK: - Public methods
    
    func load() {
        isLoading = true
        errorMessage = nil

        nfts = MockData.nfts.filter { collection.nftIds.contains($0.id) }

        isLoading = false
    }
}
