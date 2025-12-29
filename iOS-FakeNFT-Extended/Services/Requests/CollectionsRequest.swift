//
//  CollectionsRequest.swift
//  iOS-FakeNFT-Extended
//
//  Created by Diana Viter on 18.12.2025.
//

import Foundation

struct CollectionsRequest: NetworkRequest {
    var endpoint: URL? { URL(string: "\(RequestConstants.baseURL)/api/v1/collections") }
}
