//
//  NftItem.swift
//  iOS-FakeNFT-Extended
//
//  Created by Ди Di on 05/12/25.
//

import Foundation

struct NftItem: Decodable, Identifiable {
    var id: String
    var name: String?
    var images: [String]?
    var rating: Int?
    var price: Double?
    var author: String?
    var createdAt: String?
    var description: String?
    var website: URL?
}
