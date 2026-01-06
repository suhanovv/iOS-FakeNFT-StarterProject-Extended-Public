//
//  CurrencyService.swift
//  iOS-FakeNFT-Extended
//
//  Created by Pavel Komarov on 18.12.2025.
//

import Foundation

protocol CurrencyServiceProtocol {
    var currencies: [Currency] { get async throws }
    subscript(id: String) -> Currency { get async throws }
}

actor CurrencyService: CurrencyServiceProtocol {

    private let networkClient: NetworkClient

    private var cached: [Currency] = []
    private var hasLoadedAll = false

    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }

    var currencies: [Currency] {
        get async throws {
            if hasLoadedAll {
                return cached
            }

            let request = GetCurrenciesRequest()
            let result: [Currency] = try await networkClient.send(request: request)

            cached = result
            hasLoadedAll = true
            return result
        }
    }

    subscript(id: String) -> Currency {
        get async throws {
            if let found = cached.first(where: { $0.id == id }) {
                return found
            }

            let request = GetCurrencyByIdRequest(id: id)
            let result: Currency = try await networkClient.send(request: request)

            cached.append(result)
            return result
        }
    }
}
