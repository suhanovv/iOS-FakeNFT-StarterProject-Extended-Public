//
//  NftItem.swift
//  iOS-FakeNFT-Extended
//
//  Created by Ди Di on 05/12/25.
//

import Foundation

struct NftItem: Decodable, Identifiable {
    let id: String
    let name: String
    let images: [URL]
    let rating: Int
    let price: Double
    let author: URL?
    let createdAt: Date?
    let description: String?
    let website: URL?
}
