//
//  CartView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Pavel Komarov on 02.01.2026.
//

import SwiftUI

struct CartView: View {

    // MARK: - Properties

    @Bindable var viewModel: ViewModel
    var onPayment: () -> Void

    @State private var itemToDelete: CartItemViewModel?
    @State private var showSortOptions = false

    private var isShowingDeleteConfirmation: Bool {
        itemToDelete != nil
    }

    // MARK: - View

    var body: some View {
        ZStack {
            Color.ypWhite.ignoresSafeArea()

            VStack(spacing: 0) {
                navigationBar

                switch viewModel.state {
                case .initial, .loading:
                    Spacer()
                    ProgressView()
                    Spacer()
                case .loaded:
                    if viewModel.isEmpty {
                        emptyStateView
                    } else {
                        cartList
                        bottomBar
                    }
                case .error(let message):
                    errorView(message: message)
                }
            }
            .blur(radius: isShowingDeleteConfirmation ? 10 : 0)

            if let item = itemToDelete {
                deleteConfirmationOverlay(for: item)
            }
        }
        .animation(.easeInOut(duration: 0.2), value: itemToDelete?.id)
        .confirmationDialog(String(localized: "Cart.sorting.title"), isPresented: $showSortOptions, titleVisibility: .visible) {
            Button(String(localized: "Cart.sorting.byPrice")) { viewModel.setSortOption(.price) }
            Button(String(localized: "Cart.sorting.byRating")) { viewModel.setSortOption(.rating) }
            Button(String(localized: "Cart.sorting.byName")) { viewModel.setSortOption(.name) }
            Button(String(localized: "Cart.sorting.close"), role: .cancel) {}
        }
        .task {
            await viewModel.loadCart()
        }
    }

    // MARK: - Subviews

    private var navigationBar: some View {
        HStack {
            Spacer()
            Button { showSortOptions = true } label: {
                Image(.CommonIcons.sort)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 42, height: 42)
                    .foregroundStyle(.ypBlack)
            }
            .frame(width: 44, height: 44)
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 2)
    }

    private var cartList: some View {
        ScrollView {
            LazyVStack(spacing: 32) {
                ForEach(viewModel.cartItems) { item in
                    CartCardView(
                        image: item.displayImage,
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
                Text("\(viewModel.itemCount) " + String(localized: "NFT"))
                    .font(.subheadline)
                    .foregroundStyle(.ypBlack)
                Text(viewModel.formattedTotalPrice)
                    .font(.headline)
                    .bold()
                    .foregroundStyle(.ypGreenUniversal)
            }

            Button(action: onPayment) {
                Text(String(localized: "Cart.checkoutButton"))
                    .font(.headline)
                    .foregroundStyle(.ypWhite)
                    .frame(maxWidth: .infinity)
                    .frame(height: 44)
            }
            .background(.ypBlack, in: RoundedRectangle(cornerRadius: 16))
        }
        .padding()
        .background(.ypLightGray, in: RoundedRectangle(cornerRadius: 12))
    }

    private var emptyStateView: some View {
        VStack {
            Spacer()
            Text(String(localized: "Cart.empty.title"))
                .font(.headline)
                .foregroundStyle(.ypBlack)
            Spacer()
        }
    }

    private func errorView(message: String) -> some View {
        VStack {
            Spacer()
            Text(message)
                .font(.headline)
                .foregroundStyle(.ypBlackUniversal)
            Spacer()
        }
    }

    private func deleteConfirmationOverlay(for item: CartItemViewModel) -> some View {
        Color.clear
            .ignoresSafeArea()
            .contentShape(Rectangle())
            .onTapGesture {
                itemToDelete = nil
            }
            .overlay {
                CartDeleteConfirmationView(
                    image: item.displayImage,
                    onDelete: {
                        Task {
                            await viewModel.deleteItem(item)
                        }
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

// MARK: - Cart Sort Option

enum CartSortOption {
    case price
    case rating
    case name
}

// MARK: - Previews

#Preview("Default") {
    let mockServices = ServicesAssembly(
        networkClient: DefaultNetworkClient(),
        nftStorage: NftStorageImpl()
    )
    let viewModel = CartView.ViewModel(
        orderService: mockServices.orderService,
        nftService: mockServices.nftService
    )
    return CartView(
        viewModel: viewModel,
        onPayment: {}
    )
}

#Preview("Empty") {
    let mockServices = ServicesAssembly(
        networkClient: DefaultNetworkClient(),
        nftStorage: NftStorageImpl()
    )
    let viewModel = CartView.ViewModel(
        orderService: mockServices.orderService,
        nftService: mockServices.nftService
    )
    viewModel.setEmptyState()
    return CartView(
        viewModel: viewModel,
        onPayment: {}
    )
}
