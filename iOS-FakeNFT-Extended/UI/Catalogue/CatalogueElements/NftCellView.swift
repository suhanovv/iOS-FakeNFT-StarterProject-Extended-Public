//
//  NftCellView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Diana Viter on 09.12.2025.
//


import SwiftUI
import Kingfisher

// MARK: - NftCellView

struct NftCellView: View {
    
    // MARK: - Properties
    
    let nftId: String
    let name: String
    let price: Double
    let rating: Int
    let imageURL: URL?
    let isFavorite: Bool
    let isInCart: Bool
    let onFavoriteTap: () -> Void
    let onCartTap: () -> Void
    
    // MARK: - Init
    
    init(
        nftId: String,
        name: String,
        price: Double,
        rating: Int,
        imageURL: URL?,
        isFavorite: Bool = false,
        isInCart: Bool = false,
        onFavoriteTap: @escaping () -> Void = {},
        onCartTap: @escaping () -> Void = {}
    ) {
        self.nftId = nftId
        self.name = name
        self.price = price
        self.rating = rating
        self.imageURL = imageURL
        self.isFavorite = isFavorite
        self.isInCart = isInCart
        self.onFavoriteTap = onFavoriteTap
        self.onCartTap = onCartTap
    }
    
    // MARK: - Body

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            nftImageSection
            ratingSection
            infoSection
        }
        .frame(alignment: .leading)
    }
    
    // MARK: - Views

    private var nftImageSection: some View {
        ZStack(alignment: .topTrailing) {
            if let url = imageURL {
                KFImage(url)
                    .resizable()
                    .scaledToFill()
                    .clipped()
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                
                Button(action: onFavoriteTap) {
                    Image("Nft Card Icons/Like")
                        .renderingMode(.template)
                        .foregroundStyle(isFavorite ? .ypRedUniversal : .ypWhiteUniversal)
                }
            }
        }
    }

    private var ratingSection: some View {
        HStack(spacing: 2) {
            ForEach(0..<5, id: \.self) { index in
                Image(systemName: "star.fill")
                    .font(.caption)
                    .foregroundColor(index < rating ? .ypYellowUniversal : .gray.opacity(0.1))
            }
        }
    }

    private var infoSection: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(name.capitalized)
                    .font(.system(size: 17, weight: .bold))
                    .lineLimit(1)

                Text("\(price.formattedPrice()) ETH")
                    .font(.caption)
            }

            Spacer()

            Button(action: onCartTap) {
                Image(isInCart ? "Nft Card Icons/CartDelete" : "Nft Card Icons/CartAdd")
                    .foregroundStyle(.ypBlackUniversal)
            }
        }
    }
}

// MARK: - Preview_NftCellView

#Preview {
    NftCellView(
        nftId: "1",
        name: "Archie",
        price: 1,
        rating: 3,
        imageURL: URL(string: "https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/April/1.png"),
        isFavorite: true,
        isInCart: true
    )
    .frame(width: 108, height: 108)
}
