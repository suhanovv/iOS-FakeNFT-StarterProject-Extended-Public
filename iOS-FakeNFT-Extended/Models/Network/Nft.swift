//
//  Nft.swift
//  iOS-FakeNFT-Extended
//
//  Created by Pavel Komarov on 18.12.2025.
//

import Foundation

struct Nft: Decodable, Identifiable {
    let id: String
    let images: [URL]
    let name: String
    let rating: Int
    let price: Double
}
