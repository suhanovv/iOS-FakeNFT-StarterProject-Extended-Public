//
//  PaymentResult.swift
//  iOS-FakeNFT-Extended
//
//  Created by Pavel Komarov on 18.12.2025.
//

import Foundation

struct PaymentResult: Decodable {
    let success: Bool
    let orderId: String
    let id: String
}
