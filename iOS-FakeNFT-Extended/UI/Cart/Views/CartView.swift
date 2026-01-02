//
//  CartView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Pavel Komarov on 02.01.2026.
//

import SwiftUI

struct CartView: View {

    // MARK: - Properties

    var cartItems: [CartItem]
    var onSort: () -> Void
    var onPayment: () -> Void
    var onDelete: (CartItem) -> Void

    @State private var itemToDelete: CartItem?

    private var isShowingDeleteConfirmation: Bool {
        itemToDelete != nil
    }

    private var totalPrice: Double {
        cartItems.reduce(0) { $0 + $1.price }
    }

    private var formattedTotalPrice: String {
        String(format: "%.2f ETH", totalPrice).replacingOccurrences(of: ".", with: ",")
    }

    // MARK: - View

    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                navigationBar

                if cartItems.isEmpty {
                    emptyStateView
                } else {
                    cartList
                    bottomBar
                }
            }
            .blur(radius: isShowingDeleteConfirmation ? 10 : 0)

            if let item = itemToDelete {
                deleteConfirmationOverlay(for: item)
            }
        }
        .animation(.easeInOut(duration: 0.2), value: itemToDelete?.id)
    }

    // MARK: - Subviews

    private var navigationBar: some View {
        HStack {
            Spacer()
            Button(action: onSort) {
                Image(.CommonIcons.sort)
                    .font(.title2)
                    .foregroundStyle(.ypBlackUniversal)
            }
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 2)
    }

    private var cartList: some View {
        ScrollView {
            LazyVStack(spacing: 32) {
                ForEach(cartItems) { item in
                    CartCardView(
                        image: item.image,
                        name: item.name,
                        rating: item.rating,
                        priceText: item.formattedPrice,
                        onDelete: {
                            itemToDelete = item
                        }
                    )
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 20)
            .padding(.bottom, 16)
        }
    }

    private var bottomBar: some View {
        HStack(spacing: 24) {
            VStack(alignment: .leading, spacing: 2) {
                Text("\(cartItems.count) NFT")
                    .font(.subheadline)
                    .foregroundStyle(.ypBlackUniversal)
                Text(formattedTotalPrice)
                    .font(.headline)
                    .bold()
                    .foregroundStyle(.ypGreenUniversal)
            }

            Button(action: onPayment) {
                Spacer()
                Text("К оплате")
                    .font(.headline)
                    .foregroundStyle(.ypWhiteUniversal)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 19)
                Spacer()
            }
            .background(.ypBlackUniversal, in: RoundedRectangle(cornerRadius: 16))
        }
        .padding()
        .background(.ypLightGray, in: RoundedRectangle(cornerRadius: 12))
    }

    private var emptyStateView: some View {
        VStack {
            Spacer()
            Text("Корзина пуста")
                .font(.headline)
                .foregroundStyle(.ypBlackUniversal)
            Spacer()
        }
    }

    private func deleteConfirmationOverlay(for item: CartItem) -> some View {
        Color.clear
            .ignoresSafeArea()
            .contentShape(Rectangle())
            .onTapGesture {
                itemToDelete = nil
            }
            .overlay {
                CartDeleteConfirmationView(
                    image: item.image,
                    onDelete: {
                        onDelete(item)
                        itemToDelete = nil
                    },
                    onCancel: {
                        itemToDelete = nil
                    }
                )
                .padding(.horizontal, 56)
            }
    }
}

// MARK: - Cart Item Model

struct CartItem: Identifiable, Equatable {
    let id: UUID
    let image: Image
    let name: String
    let rating: Int
    let price: Double

    var formattedPrice: String {
        String(format: "%.2f ETH", price).replacingOccurrences(of: ".", with: ",")
    }

    static func == (lhs: CartItem, rhs: CartItem) -> Bool {
        lhs.id == rhs.id
    }

    static let mockData: [CartItem] = [
        CartItem(
            id: UUID(),
            image: Image(.MockupImages.nftPlaceholder1),
            name: "April",
            rating: 1,
            price: 1.78
        ),
        CartItem(
            id: UUID(),
            image: Image(.MockupImages.nftPlaceholder2),
            name: "Greena",
            rating: 3,
            price: 1.78
        ),
        CartItem(
            id: UUID(),
            image: Image(.MockupImages.nftPlaceholder3),
            name: "Spring",
            rating: 5,
            price: 1.78
        )
    ]
}

// MARK: - Previews

#Preview("Default") {
    CartView(
        cartItems: CartItem.mockData,
        onSort: {},
        onPayment: {},
        onDelete: { _ in }
    )
}

#Preview("Empty") {
    CartView(
        cartItems: [],
        onSort: {},
        onPayment: {},
        onDelete: { _ in }
    )
}
