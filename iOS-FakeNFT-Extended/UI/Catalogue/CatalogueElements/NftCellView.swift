//
//  NftCellView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Diana Viter on 09.12.2025.
//

import SwiftUI

struct NftCellView: View {
    let name: String
    let price: Decimal
    let rating: Int
    let imageURL: URL?

    @State private var isFavorite: Bool
    @State private var isInCart: Bool
    
    init(
        name: String,
        price: Decimal,
        rating: Int,
        imageURL: URL?,
        isFavorite: Bool = false,
        isInCart: Bool = false
    ) {
        self.name = name
        self.price = price
        self.rating = rating
        self.imageURL = imageURL
        _isFavorite = State(initialValue: isFavorite)
        _isInCart = State(initialValue: isInCart)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {

            ZStack(alignment: .topTrailing) {
                Image(.nftCell)
                    .resizable()
                    .scaledToFill()
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))

                Button(action: onFavoriteTap) {
                    Image("Nft Card Icons/Like")
                        .renderingMode(.template)
                        .foregroundStyle(isFavorite ? .ypRedUniversal : .ypWhiteUniversal)
                }
            }

            HStack(spacing: 2) {
                ForEach(0..<5, id: \.self) { index in
                    Image(systemName: "star.fill")
                        .font(.caption)
                        .foregroundColor(index < rating ? .ypYellowUniversal : .gray.opacity(0.1))
                }
            }

            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(name)
                        .font(.init(UIFont.bodyBold))

                    Text("\(price) ETH")
                        .font(.caption)
                }

                Spacer()

                Button(action: onCartTap) {
                    Image(isInCart ? "Nft Card Icons/CartDelete" : "Nft Card Icons/CartAdd")
                        .foregroundStyle(.ypBlackUniversal)
                }
            }
        }
        .frame(alignment: .leading)
    }
    
    // MARK: - Actions

    private func onFavoriteTap() {
        isFavorite.toggle()
    }

    private func onCartTap() {
        isInCart.toggle()
    }
}

#Preview {
    NftCellView(
        name: "Archie",
        price: 1,
        rating: 3,
        imageURL: nil,
        isFavorite: true,
        isInCart: true
    )
    .frame(width: 108, height: 108)
}
