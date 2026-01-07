//
//  MockNftService.swift
//  iOS-FakeNFT-Extended
//
//  Created by Diana Viter on 14.12.2025.
//

struct MockNftService: NftService {
    func loadNft(id: String) async throws -> Nft {
        MockData.nfts.first { $0.id == id } ?? MockData.nfts[0]
    }
}
