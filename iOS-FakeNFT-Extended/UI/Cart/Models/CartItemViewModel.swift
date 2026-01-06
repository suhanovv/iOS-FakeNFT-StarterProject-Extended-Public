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

    // MARK: - Mock Data (for Previews only)

    #if DEBUG
    static let mockData: [CartItemViewModel] = [
        CartItemViewModel(
            id: "1",
            imageURL: URL(string: "https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/April/1.png"),
            name: "April",
            rating: 1,
            price: 1.78
        ),
        CartItemViewModel(
            id: "2",
            imageURL: URL(string: "https://code.s3.yandex.net/Mobile/iOS/NFT/Gray/Piper/1.png"),
            name: "Greena",
            rating: 3,
            price: 2.34
        ),
        CartItemViewModel(
            id: "3",
            imageURL: URL(string: "https://code.s3.yandex.net/Mobile/iOS/NFT/Brown/Emma/1.png"),
            name: "Spring",
            rating: 5,
            price: 0.95
        )
    ]
    #endif
}
