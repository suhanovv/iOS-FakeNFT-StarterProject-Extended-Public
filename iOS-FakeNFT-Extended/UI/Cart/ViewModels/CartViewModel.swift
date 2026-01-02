//
//  CartViewModel.swift
//  iOS-FakeNFT-Extended
//
//  Created by Pavel Komarov on 02.01.2026.
//

import Observation
import Foundation

extension CartView {
    @Observable
    @MainActor
    final class ViewModel {

        // MARK: - State

        private(set) var state: CartScreenState = .initial
        private(set) var cartItems: [CartItemViewModel] = []
        private(set) var sortOption: CartSortOption = .name

        // MARK: - Computed Properties

        var totalPrice: Double {
            cartItems.reduce(0) { $0 + $1.price }
        }

        var formattedTotalPrice: String {
            String(format: "%.2f ETH", totalPrice).replacingOccurrences(of: ".", with: ",")
        }

        var itemCount: Int {
            cartItems.count
        }

        var isEmpty: Bool {
            cartItems.isEmpty
        }

        // MARK: - Dependencies

        private let orderService: OrderServiceProtocol
        private let nftService: NftService

        // MARK: - Private

        private var allItems: [CartItemViewModel] = []

        // MARK: - Init

        init(orderService: OrderServiceProtocol, nftService: NftService) {
            self.orderService = orderService
            self.nftService = nftService
        }

        // MARK: - Public Methods

        func loadCart() async {
            state = .loading
            // Mock implementation for Milestone 2
            // In Milestone 3...
            // let order = try await orderService.getOrder()
            // allItems = order.nfts.map { ... }
            allItems = CartItemViewModel.mockData
            applySort()
            state = .loaded
        }

        func deleteItem(_ item: CartItemViewModel) async {
            // Mock: remove from local array
            // In Milestone 3... await orderService.removeFromCartNft(item.id)
            allItems.removeAll { $0.id == item.id }
            applySort()
        }

        func setSortOption(_ option: CartSortOption) {
            sortOption = option
            applySort()
        }

        func clearCartAfterPayment() {
            allItems = []
            cartItems = []
        }

        // MARK: - Private Methods

        private func applySort() {
            switch sortOption {
            case .price:
                cartItems = allItems.sorted { $0.price < $1.price }
            case .rating:
                cartItems = allItems.sorted { $0.rating > $1.rating }
            case .name:
                cartItems = allItems.sorted {
                    $0.name.localizedCaseInsensitiveCompare($1.name) == .orderedAscending
                }
            }
        }
    }
}
