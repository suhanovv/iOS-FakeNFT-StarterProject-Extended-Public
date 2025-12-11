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

    init(
        id: String,
        name: String? = nil,
        images: [String]? = nil,
        rating: Int? = nil,
        price: Double? = nil,
        author: String? = nil,
        createdAt: String? = nil,
        description: String? = nil,
        website: URL? = nil
    ) {
        self.id = id
        self.name = name
        self.images = images
        self.rating = rating
        self.price = price
        self.author = author
        self.createdAt = createdAt
        self.description = description
        self.website = website
    }
}
