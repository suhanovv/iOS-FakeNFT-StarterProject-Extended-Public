//
//  CartCheckoutViewModel.swift
//  iOS-FakeNFT-Extended
//
//  Created by Pavel Komarov on 02.01.2026.
//

import Observation
import Foundation

extension CartCheckoutView {
    @Observable
    @MainActor
    final class ViewModel {

        // MARK: - State

        private(set) var state: CartScreenState = .initial
        private(set) var currencies: [Currency] = []
        var selectedCurrency: Currency?

        // MARK: - Alerts and Navigation

        var showPaymentError = false
        var showPaymentSuccess = false

        // MARK: - Dependencies

        private let currencyService: CurrencyServiceProtocol
        private let paymentService: PaymentServiceProtocol
        private let orderId: String

        // MARK: - Init

        init(
            currencyService: CurrencyServiceProtocol,
            paymentService: PaymentServiceProtocol,
            orderId: String = "1"
        ) {
            self.currencyService = currencyService
            self.paymentService = paymentService
            self.orderId = orderId
        }

        // MARK: - Public Methods

        func loadCurrencies() async {
            state = .loading
            // Mock implementation for Milestone 2
            // In Milestone 3...
            // currencies = try await currencyService.getCurrencies()
            currencies = Currency.mockData
            state = .loaded
        }

        func pay() async {
            guard let currency = selectedCurrency else { return }
            state = .loading

            // Mock: simulate successful payment
            try? await Task.sleep(for: .milliseconds(500))

            // In Milestone 3...
            // do {
            //     let result = try await paymentService.pay(orderId: orderId, currencyId: currency.id)
            //     if result.success {
            //         showPaymentSuccess = true
            //     } else {
            //         showPaymentError = true
            //     }
            // } catch {
            //     showPaymentError = true
            // }

            _ = currency // silence unused warning
            showPaymentSuccess = true
            state = .loaded
        }

        func retryPayment() async {
            showPaymentError = false
            await pay()
        }
    }
}

// MARK: - Currency Mock Data

extension Currency {
    static let mockData: [Currency] = [
        Currency(id: "1", title: "Bitcoin", name: "BTC", image: URL(string: "https://example.com/btc.png")!),
        Currency(id: "2", title: "Dogecoin", name: "DOGE", image: URL(string: "https://example.com/doge.png")!),
        Currency(id: "3", title: "Tether", name: "USDT", image: URL(string: "https://example.com/usdt.png")!),
        Currency(id: "4", title: "Apecoin", name: "APE", image: URL(string: "https://example.com/ape.png")!),
        Currency(id: "5", title: "Solana", name: "SOL", image: URL(string: "https://example.com/sol.png")!),
        Currency(id: "6", title: "Ethereum", name: "ETH", image: URL(string: "https://example.com/eth.png")!),
        Currency(id: "7", title: "Cardano", name: "ADA", image: URL(string: "https://example.com/ada.png")!),
        Currency(id: "8", title: "Shiba Inu", name: "SHIB", image: URL(string: "https://example.com/shib.png")!)
    ]
}
