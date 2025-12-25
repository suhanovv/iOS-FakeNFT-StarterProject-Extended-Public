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

    // MARK: - View

    var body: some View {
        VStack(spacing: 20) {
            VStack(spacing: 12) {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 108, height: 108)
                    .clipShape(RoundedRectangle(cornerRadius: 12))

                Text("Вы уверены, что хотите\nудалить объект из корзины?")
                    .font(.footnote)
                    .foregroundStyle(.ypBlackUniversal)
                    .multilineTextAlignment(.center)
            }

            HStack(spacing: 8) {
                deleteButton(title: "Удалить", textColor: .ypRedUniversal, action: onDelete)
                deleteButton(title: "Вернуться", textColor: .ypWhiteUniversal, action: onCancel)
            }
        }
    }

    // MARK: - Private Methods

    private func deleteButton(title: String, textColor: Color, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Text(title)
                .foregroundStyle(textColor)
                .frame(width: 127)
                .padding(.horizontal, 16)
                .padding(.vertical, 11)
        }
        .background(.ypBlackUniversal, in: RoundedRectangle(cornerRadius: 12))
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
