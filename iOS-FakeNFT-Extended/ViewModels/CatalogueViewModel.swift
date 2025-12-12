//
//  CatalogueViewModel.swift
//  iOS-FakeNFT-Extended
//
//  Created by Diana Viter on 10.12.2025.
//

import SwiftUI

final class CatalogueViewModel: ObservableObject {

    // MARK: - External dependencies
    
    private let services: ServicesAssembly?

    // MARK: - Source
    
    private var allCollections: [CollectionDTO] = []

    // MARK: - State model

    @Published var collections: [CollectionDTO] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published private(set) var sortOption: CollectionsSortOption = .name

    // MARK: - Init

    init(services: ServicesAssembly? = nil) {
        self.services = services
    }

    // MARK: - Public methods

    func load() {
        isLoading = true
        errorMessage = nil

        allCollections = MockData.collections

        applySort()
        isLoading = false
    }

    func setSortOption(_ option: CollectionsSortOption) {
        sortOption = option
        applySort()
    }

    // MARK: - Private methods

    private func applySort() {
        switch sortOption {
        case .name:
            collections = allCollections.sorted {
                $0.name.localizedCaseInsensitiveCompare($1.name) == .orderedAscending
            }

        case .nftCount:
            collections = allCollections.sorted {
                if $0.nftIds.count == $1.nftIds.count {
                    return $0.name.localizedCaseInsensitiveCompare($1.name) == .orderedAscending
                }
                return $0.nftIds.count > $1.nftIds.count
            }
        }
    }
}
