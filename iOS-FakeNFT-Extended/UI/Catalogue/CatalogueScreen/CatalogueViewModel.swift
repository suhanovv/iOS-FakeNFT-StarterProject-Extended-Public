//
//  CatalogueViewModel.swift
//  iOS-FakeNFT-Extended
//
//  Created by Diana Viter on 10.12.2025.
//

import SwiftUI

@MainActor
final class CatalogueViewModel: ObservableObject {

    // MARK: - External dependencies
    
    private let collectionsService: CollectionsServiceProtocol

    // MARK: - Source
    
    private var allCollections: [CollectionDTO] = []

    // MARK: - State model

    @Published var collections: [CollectionDTO] = []
    @Published var state: ScreenState = .initial
    @Published private(set) var sortOption: CollectionsSortOption = .nftCount

    // MARK: - Init

    init(collectionsService: CollectionsServiceProtocol = CollectionsService()) {
        self.collectionsService = collectionsService
    }

    // MARK: - Public methods

    func load() async {
        state = .loading
        do {
            let collections = try await collectionsService.fetchCollections()
            allCollections = collections
            applySort()
            state = .loaded
        } catch {
            state = .error(error.localizedDescription)
        }
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
