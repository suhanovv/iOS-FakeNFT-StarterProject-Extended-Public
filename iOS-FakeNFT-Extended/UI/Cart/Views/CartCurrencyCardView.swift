//
//  CartCurrencyCardView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Pavel Komarov on 19.12.2025.
//

import SwiftUI
import Kingfisher

struct CartCurrencyCardView: View {

    // MARK: - Properties

    let imageURL: URL?
    let title: String
    let code: String
    var isSelected: Bool

    // MARK: - View

    var body: some View {
        HStack(spacing: 4) {
            KFImage(imageURL)
                .placeholder {
                    ProgressView()
                        .frame(width: 36, height: 36)
                }
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 36, height: 36)
                .clipShape(RoundedRectangle(cornerRadius: 6))

            VStack(alignment: .leading, spacing: 0) {
                Text(title)
                    .foregroundStyle(.ypBlack)
                Text(code)
                    .foregroundStyle(.ypGreenUniversal)
            }

            Spacer()
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 5)
        .background(.ypLightGray, in: RoundedRectangle(cornerRadius: 12))
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(isSelected ? .ypBlack : .clear, lineWidth: 1)
        )
    }
}

// MARK: - Previews

#Preview("Default") {
    CartCurrencyCardView(
        imageURL: URL(string: "https://code.s3.yandex.net/Mobile/iOS/Currencies/Bitcoin_(BTC).png"),
        title: "Bitcoin",
        code: "BTC",
        isSelected: false
    )
    .padding()
}

#Preview("Selected") {
    CartCurrencyCardView(
        imageURL: URL(string: "https://code.s3.yandex.net/Mobile/iOS/Currencies/Bitcoin_(BTC).png"),
        title: "Bitcoin",
        code: "BTC",
        isSelected: true
    )
    .padding()
}
