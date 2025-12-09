//
//  CollectionDTO.swift
//  iOS-FakeNFT-Extended
//
//  Created by Diana Viter on 09.12.2025.
//

import Foundation

struct CollectionDTO: Identifiable, Codable {
    let id: String
    let name: String
    let cover: URL
    let description: String
    let authorId: String
    let authorName: String?
    let website: URL?
    let nftIds: [String]

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case cover
        case description
        case authorId = "author"
        case authorName
        case website
        case nftIds = "nfts"
    }
}
