//
//  CurrencyService.swift
//  iOS-FakeNFT-Extended
//
//  Created by Pavel Komarov on 18.12.2025.
//

import Foundation

protocol CurrencyServiceProtocol {
    func getCurrencies() async throws -> [Currency]
    func getCurrency(id: String) async throws -> Currency
}

actor CurrencyService: CurrencyServiceProtocol {

    private let networkClient: NetworkClient

    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }

    func getCurrencies() async throws -> [Currency] {
        let request = GetCurrenciesRequest()
        return try await networkClient.send(request: request)
    }

    func getCurrency(id: String) async throws -> Currency {
        let request = GetCurrencyByIdRequest(id: id)
        return try await networkClient.send(request: request)
    }
}
