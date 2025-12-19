//
//  CartCardView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Pavel Komarov on 19.12.2025.
//

import SwiftUI

struct CartCardView: View {

    // MARK: - Properties

    let image: Image
    let name: String
    let rating: Int
    let priceText: String
    let onDelete: () -> Void

    // MARK: - View

    var body: some View {
        HStack(spacing: 20) {
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 108, height: 108)
                .clipShape(RoundedRectangle(cornerRadius: 12))

            VStack(alignment: .leading, spacing: 12) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(name)
                        .bold()
                        .foregroundStyle(.ypBlackUniversal)
                    StarView(rating: rating)
                }

                VStack(alignment: .leading, spacing: 2) {
                    Text("Цена")
                        .font(.caption)
                        .foregroundStyle(.ypBlackUniversal)
                    Text(priceText)
                        .bold()
                        .foregroundStyle(.ypBlackUniversal)
                }
            }
            .padding(.vertical, 8)

            Spacer()

            Button(action: onDelete) {
                Image(.NftCardIcons.cartDelete)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .foregroundStyle(.ypBlackUniversal)
            }
            .frame(width: 44, height: 44)
        }
    }

    // MARK: - Subviews

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
        image: Image(.MockupImages.nftPlaceholder4),
        name: "April",
        rating: 4,
        priceText: "1,78 ETH",
        onDelete: {}
    )
    .padding()
}
