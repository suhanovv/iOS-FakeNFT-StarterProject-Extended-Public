//
//  PaymentService.swift
//  iOS-FakeNFT-Extended
//
//  Created by Pavel Komarov on 18.12.2025.
//

import Foundation

protocol PaymentServiceProtocol: Sendable {
    func pay(orderId: String, currencyId: String) async throws -> PaymentResult
}

actor PaymentService: PaymentServiceProtocol {

    private let networkClient: NetworkClient

    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }

    func pay(orderId: String, currencyId: String) async throws -> PaymentResult {
        let request = PayOrderRequest(orderId: orderId, currencyId: currencyId)
        return try await networkClient.send(request: request)
    }
}
