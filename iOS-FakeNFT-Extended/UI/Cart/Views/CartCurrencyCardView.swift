//
//  CartCurrencyCardView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Pavel Komarov on 19.12.2025.
//

import SwiftUI

struct CartCurrencyCardView: View {

    // MARK: - Properties

    let image: Image
    let title: String
    let code: String
    var isSelected: Bool

    // MARK: - View

    var body: some View {
        HStack(spacing: 4) {
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 36, height: 36)
                .clipShape(RoundedRectangle(cornerRadius: 6))

            VStack(alignment: .leading, spacing: 0) {
                Text(title)
                    .foregroundStyle(.ypBlackUniversal)
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
                .stroke(isSelected ? .ypBlackUniversal : .clear, lineWidth: 1)
        )
    }
}

// MARK: - Previews

#Preview("Default") {
    CartCurrencyCardView(
        image: Image(.CurrencyIcons.bitcoin),
        title: "Bitcoin",
        code: "BTC",
        isSelected: false
    )
    .padding()
}

#Preview("Selected") {
    CartCurrencyCardView(
        image: Image(.CurrencyIcons.bitcoin),
        title: "Bitcoin",
        code: "BTC",
        isSelected: true
    )
    .padding()
}
