//
//  CollectionRequest.swift
//  iOS-FakeNFT-Extended
//
//  Created by Diana Viter on 19.12.2025.
//

import Foundation

struct CollectionRequest: NetworkRequest {
    let id: String
    var endpoint: URL? { URL(string: "\(RequestConstants.baseURL)/api/v1/collections/\(id)") }
}
