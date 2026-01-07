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
    let name: String
    let rating: Int
    let price: Double

    var formattedPrice: String {
        price.formatted(.currency(code: "ETH"))
    }

    static func == (lhs: CartItemViewModel, rhs: CartItemViewModel) -> Bool {
        lhs.id == rhs.id
    }

    // MARK: - Init from Nft

    init(from nft: Nft) {
        self.id = nft.id
        self.imageURL = nft.images.first
        self.name = nft.name
        self.rating = nft.rating
        self.price = nft.price
    }

    init(
        id: String,
        imageURL: URL?,
        name: String,
        rating: Int,
        price: Double
    ) {
        self.id = id
        self.imageURL = imageURL
        self.name = name
        self.rating = rating
        self.price = price
    }
}
