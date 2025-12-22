//
//  CollectionsService.swift
//  iOS-FakeNFT-Extended
//
//  Created by Diana Viter on 13.12.2025.
//

import Foundation

protocol CollectionsServiceProtocol: Sendable {
    func fetchCollections() async throws -> [CollectionDTO]
}

actor CollectionsServiceActor: CollectionsServiceProtocol {
    private let networkClient: NetworkClient

    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }

    func fetchCollections() async throws -> [CollectionDTO] {
        try await networkClient.send(request: CollectionsRequest())
    }
}
