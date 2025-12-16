//
//  CollectionsService.swift
//  iOS-FakeNFT-Extended
//
//  Created by Diana Viter on 13.12.2025.
//

import Foundation

protocol CollectionsServiceProtocol {
    func fetchCollections() async throws -> [CollectionDTO]
}

final class CollectionsService: CollectionsServiceProtocol {

    func fetchCollections() async throws -> [CollectionDTO] {
        return MockData.collections
    }
}
