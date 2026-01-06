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

        #if DEBUG

        private var shouldSkipAutoLoad = false

        #endif

        // MARK: - Init

        init(orderService: OrderServiceProtocol, nftService: NftService) {
            self.orderService = orderService
            self.nftService = nftService
        }

        // MARK: - Public Methods

        func loadCart() async {
            #if DEBUG
            guard !shouldSkipAutoLoad else { return }
            #endif
            
            state = .loading
            do {
                let order = try await orderService.getOrder()
                let nfts = try await loadNfts(ids: order.nfts)
                allItems = nfts.map { CartItemViewModel(from: $0) }
                applySort()
                state = .loaded
            } catch {
                state = .error(error.localizedDescription)
            }
        }

        func deleteItem(_ item: CartItemViewModel) async {
            do {
                _ = try await orderService.removeFromCartNft(item.id)
                allItems.removeAll { $0.id == item.id }
                applySort()
            } catch {
                state = .error(error.localizedDescription)
            }
        }

        func setSortOption(_ option: CartSortOption) {
            sortOption = option
            applySort()
        }

        func clearCartAfterPayment() {
            allItems = []
            cartItems = []
        }

        #if DEBUG

        func setEmptyState() {
            shouldSkipAutoLoad = true
            allItems = []
            cartItems = []
            state = .loaded
        }

        #endif // DEBUG

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

        private func loadNfts(ids: [String]) async throws -> [Nft] {
            try await withThrowingTaskGroup(of: Nft.self) { group in
                for id in ids {
                    group.addTask {
                        try await self.nftService.loadNft(id: id)
                    }
                }
                var nfts: [Nft] = []
                for try await nft in group {
                    nfts.append(nft)
                }
                return nfts
            }
        }
    }
}
