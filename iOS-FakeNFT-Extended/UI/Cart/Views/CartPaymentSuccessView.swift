//
//  CartPaymentSuccessView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Pavel Komarov on 02.01.2026.
//

import SwiftUI

struct CartPaymentSuccessView: View {

    // MARK: - Properties

    let image: Image = Image(.checkout)
    let onReturn: () -> Void

    // MARK: - View

    var body: some View {
        VStack {
            Spacer()

            VStack(spacing: 20) {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 278, height: 278)

                Text(String(localized: "Cart.paymentSuccess.title"))
                    .font(.title2)
                    .bold()
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.ypBlackUniversal)
            }

            Spacer()

            Button(action: onReturn) {
                Text(String(localized: "Cart.paymentSuccess.returnButton"))
                    .font(.headline)
                    .foregroundStyle(.ypWhiteUniversal)
                    .frame(maxWidth: .infinity)
                    .frame(height: 60)
            }
            .background(.ypBlackUniversal, in: RoundedRectangle(cornerRadius: 16))
            .padding()
        }
    }
}

// MARK: - Previews

#Preview {
    CartPaymentSuccessView(
        onReturn: {}
    )
}
