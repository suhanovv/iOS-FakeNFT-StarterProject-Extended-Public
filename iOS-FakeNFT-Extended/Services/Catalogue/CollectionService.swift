//
//  CollectionService.swift
//  iOS-FakeNFT-Extended
//
//  Created by Diana Viter on 18.12.2025.
//

import Foundation

protocol CollectionServiceProtocol: Sendable {
    func fetchCollection(id: String) async throws -> CollectionDTO
    func loadNfts(ids: [String]) async throws -> [Nft]
}

actor CollectionServiceActor: CollectionServiceProtocol {
    private let networkClient: NetworkClient

    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }

    func fetchCollection(id: String) async throws -> CollectionDTO {
        try await networkClient.send(request: CollectionRequest(id: id))
    }

    func loadNfts(ids: [String]) async throws -> [Nft] {
        let cleaned = ids
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .filter { !$0.isEmpty }

        if cleaned.isEmpty { return [] }

        return try await withThrowingTaskGroup(of: (Int, Nft).self) { group in
            for (index, id) in cleaned.enumerated() {
                group.addTask { [networkClient] in
                    let nft: Nft = try await networkClient.send(request: NFTRequest(id: id))
                    return (index, nft)
                }
            }

            var buffer = Array<Nft?>(repeating: nil, count: cleaned.count)
            for try await (index, nft) in group {
                buffer[index] = nft
            }
            return buffer.compactMap { $0 }
        }
    }
}

