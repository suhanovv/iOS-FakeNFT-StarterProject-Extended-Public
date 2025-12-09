//
//  AuthorDTO.swift
//  iOS-FakeNFT-Extended
//
//  Created by Diana Viter on 09.12.2025.
//

import Foundation

struct AuthorDTO: Decodable, Identifiable {
    let id: String
    let name: String
    let website: URL?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case website
    }
}
