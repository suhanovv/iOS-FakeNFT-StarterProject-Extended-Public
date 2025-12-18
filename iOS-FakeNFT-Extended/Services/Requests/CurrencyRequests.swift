//
//  CurrencyRequests.swift
//  iOS-FakeNFT-Extended
//
//  Created by Pavel Komarov on 18.12.2025.
//

import Foundation

struct GetCurrenciesRequest: NetworkRequest {
    var endpoint: URL? {
        URL(string: "\(RequestConstants.baseURL)/api/v1/currencies")
    }
}

struct GetCurrencyByIdRequest: NetworkRequest {
    let id: String

    var endpoint: URL? {
        URL(string: "\(RequestConstants.baseURL)/api/v1/currencies/\(id)")
    }
}
