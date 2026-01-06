//
//  CartCardView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Pavel Komarov on 19.12.2025.
//

import SwiftUI
import Kingfisher

struct CartCardView: View {

    // MARK: - Properties

    let imageURL: URL?
    let name: String
    let rating: Int
    let priceText: String
    let onDelete: () -> Void

    // MARK: - View

    var body: some View {
        HStack(spacing: 20) {
            nftImage
                .frame(width: 108, height: 108)
                .clipShape(RoundedRectangle(cornerRadius: 12))

            VStack(alignment: .leading, spacing: 12) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(name)
                        .bold()
                        .foregroundStyle(.ypBlack)
                    StarView(rating: rating)
                }

                VStack(alignment: .leading, spacing: 2) {
                    Text(String(localized: "Common.price"))
                        .font(.caption)
                        .foregroundStyle(.ypBlack)
                    Text(priceText)
                        .bold()
                        .foregroundStyle(.ypBlack)
                }
            }
            .padding(.vertical, 8)

            Spacer()

            Button(action: onDelete) {
                Image(.NftCardIcons.cartDelete)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .foregroundStyle(.ypBlack)
            }
            .frame(width: 44, height: 44)
        }
    }

    // MARK: - Subviews

    @ViewBuilder
    private var nftImage: some View {
        KFImage(imageURL)
            .placeholder {
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.ypLightGray)
            }
            .resizable()
            .aspectRatio(contentMode: .fill)
    }

    private struct StarView: View {
        let rating: Int

        var body: some View {
            let normalizedRating = min(max(rating, 0), 5)
            HStack(spacing: 2) {
                ForEach(1 ... 5, id: \.self) { index in
                    Image(systemName: "star.fill")
                        .font(.system(size: 12))
                        .foregroundStyle(
                            index <= normalizedRating
                                ? .ypYellowUniversal
                                : .ypLightGray
                        )
                }
            }
        }
    }
}

// MARK: - Previews

#Preview {
    CartCardView(
        imageURL: URL(string: "https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/April/1.png"),
        name: "April",
        rating: 4,
        priceText: "1,78 ETH",
        onDelete: {}
    )
    .padding()
}
