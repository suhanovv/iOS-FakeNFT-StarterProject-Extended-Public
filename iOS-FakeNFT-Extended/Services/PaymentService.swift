//
//  PaymentService.swift
//  iOS-FakeNFT-Extended
//
//  Created by Pavel Komarov on 18.12.2025.
//

import Foundation

protocol PaymentService {
    func pay(currencyId: String) async throws -> PaymentResult
}

@MainActor
final class PaymentServiceImpl: PaymentService {

    private let networkClient: NetworkClient
    private let orderId: String

    init(networkClient: NetworkClient, orderId: String = "1") {
        self.networkClient = networkClient
        self.orderId = orderId
    }

    func pay(currencyId: String) async throws -> PaymentResult {
        let request = PayOrderRequest(orderId: orderId, currencyId: currencyId)
        return try await networkClient.send(request: request)
    }
}
