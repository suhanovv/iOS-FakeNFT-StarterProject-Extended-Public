//
//  CartDeleteConfirmationView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Pavel Komarov on 20.12.2025.
//

import SwiftUI

struct CartDeleteConfirmationView: View {

    // MARK: - Properties

    let image: Image
    let onDelete: () -> Void
    let onCancel: () -> Void

    @State private var buttonWidth: CGFloat = 0

    // MARK: - View

    var body: some View {
        ZStack {
            Color.ypWhite.ignoresSafeArea()

            VStack(spacing: 20) {
                VStack(spacing: 12) {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 108, height: 108)
                        .clipShape(RoundedRectangle(cornerRadius: 12))

                    Text(String(localized: "Cart.deleteConfirmation.title"))
                        .font(.footnote)
                        .foregroundStyle(.ypBlack)
                        .multilineTextAlignment(.center)
                }

                HStack(spacing: 8) {
                    deleteButton(title: String(localized: "Cart.deleteConfirmation.deleteButton"), textColor: .ypRedUniversal, action: onDelete)
                    deleteButton(title: String(localized: "Cart.deleteConfirmation.returnButton"), textColor: .ypWhite, action: onCancel)
                }
                .onPreferenceChange(ButtonWidthPreferenceKey.self) { width in
                    buttonWidth = width
                }
            }
        }
    }

    // MARK: - Private Methods

    private func deleteButton(title: String, textColor: Color, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Text(title)
                .foregroundStyle(textColor)
                .padding(.horizontal, 22)
                .padding(.vertical, 11)
                .background(
                    GeometryReader { geo in
                        Color.clear.preference(
                            key: ButtonWidthPreferenceKey.self,
                            value: geo.size.width
                        )
                    }
                )
                .frame(width: buttonWidth > 0 ? buttonWidth : nil)
        }
        .background(.ypBlack, in: RoundedRectangle(cornerRadius: 12))
    }
}

// MARK: - Preference Key

private struct ButtonWidthPreferenceKey: PreferenceKey {
    static let defaultValue: CGFloat = 0

    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = max(value, nextValue())
    }
}

// MARK: - Previews

#Preview {
    CartDeleteConfirmationView(
        image: Image(.MockupImages.nftPlaceholder4),
        onDelete: {},
        onCancel: {}
    )
    .padding()
}
