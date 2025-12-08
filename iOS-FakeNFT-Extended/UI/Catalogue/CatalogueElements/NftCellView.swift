//
//  NftCellView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Diana Viter on 05.12.2025.
//

import SwiftUI

struct NftCellView: View {
    let name: String
    let price: Decimal
    let rating: Int
    let imageURL: URL?

    let isFavorite: Bool
    let isInCart: Bool
    var onFavoriteTap: () -> Void = {}
    var onCartTap: () -> Void = {}

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {

            ZStack(alignment: .topTrailing) {
                Image(.nftCell)
                    .resizable()
                    .scaledToFill()
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))

                Button(action: onFavoriteTap) {
                    Image("Nft Card Icons/Like")
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
