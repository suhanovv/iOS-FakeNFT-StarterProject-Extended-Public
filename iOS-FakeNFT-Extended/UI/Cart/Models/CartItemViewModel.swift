//
//  CartItemViewModel.swift
//  iOS-FakeNFT-Extended
//
//  Created by Pavel Komarov on 02.01.2026.
//

import SwiftUI

struct CartItemViewModel: Identifiable, Equatable {
    let id: String
    let imageURL: URL?
    let placeholderImage: Image
    let name: String
    let rating: Int
    let price: Double

    var formattedPrice: String {
        price.formatted(.currency(code: "ETH"))
    }

    var displayImage: Image {
        placeholderImage
    }

    static func == (lhs: CartItemViewModel, rhs: CartItemViewModel) -> Bool {
        lhs.id == rhs.id
    }

    // MARK: - Mock Data

    static let mockData: [CartItemViewModel] = [
        CartItemViewModel(
            id: "1",
            imageURL: nil,
            placeholderImage: Image(.MockupImages.nftPlaceholder1),
            name: "April",
            rating: 1,
            price: 1.78
        ),
        CartItemViewModel(
            id: "2",
            imageURL: nil,
            placeholderImage: Image(.MockupImages.nftPlaceholder2),
            name: "Greena",
            rating: 3,
            price: 2.34
        ),
        CartItemViewModel(
            id: "3",
            imageURL: nil,
            placeholderImage: Image(.MockupImages.nftPlaceholder3),
            name: "Spring",
            rating: 5,
            price: 0.95
        )
    ]
}
