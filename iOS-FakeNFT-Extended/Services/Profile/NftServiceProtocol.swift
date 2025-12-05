//
//  NftServiceProtocol.swift
//  iOS-FakeNFT-Extended
//
//  Created by Ди Di on 05/12/25.
//

protocol NftServiceProtocol {
    func fetchNft(id: String) async throws -> NftItem
}
