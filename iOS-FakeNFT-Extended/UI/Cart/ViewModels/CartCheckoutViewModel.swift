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
        private let orderService: OrderServiceProtocol
        private let orderId: String

        // MARK: - Init

        init(
            currencyService: CurrencyServiceProtocol,
            paymentService: PaymentServiceProtocol,
            orderService: OrderServiceProtocol,
            orderId: String = "1"
        ) {
            self.currencyService = currencyService
            self.paymentService = paymentService
            self.orderService = orderService
            self.orderId = orderId
        }

        // MARK: - Public Methods

        func loadCurrencies() async {
            state = .loading
            do {
                currencies = try await currencyService.currencies
                state = .loaded
            } catch {
                state = .error(error.localizedDescription)
            }
        }

        func pay() async {
            guard let currency = selectedCurrency else { return }
            state = .loading

            do {
                let result = try await paymentService.pay(orderId: orderId, currencyId: currency.id)
                if result.success {
                    // Clear cart on server after successful payment
                    _ = try await orderService.clearCart()
                    showPaymentSuccess = true
                } else {
                    showPaymentError = true
                }
                state = .loaded
            } catch {
                showPaymentError = true
                state = .loaded
            }
        }

        func retryPayment() async {
            showPaymentError = false
            await pay()
        }
    }
}


