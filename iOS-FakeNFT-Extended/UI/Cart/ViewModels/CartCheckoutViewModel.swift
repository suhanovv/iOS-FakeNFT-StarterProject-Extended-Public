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

// MARK: - Currency Mock Data (for Previews only)

#if DEBUG
extension Currency {
    static let mockData: [Currency] = [
        Currency(id: "5", title: "Bitcoin", name: "BTC", image: URL(string: "https://code.s3.yandex.net/Mobile/iOS/Currencies/Bitcoin_(BTC).png")!),
        Currency(id: "6", title: "Dogecoin", name: "DOGE", image: URL(string: "https://code.s3.yandex.net/Mobile/iOS/Currencies/Dogecoin_(DOGE).png")!),
        Currency(id: "2", title: "Tether", name: "USDT", image: URL(string: "https://code.s3.yandex.net/Mobile/iOS/Currencies/Tether_(USDT).png")!),
        Currency(id: "3", title: "Apecoin", name: "APE", image: URL(string: "https://code.s3.yandex.net/Mobile/iOS/Currencies/ApeCoin_(APE).png")!),
        Currency(id: "4", title: "Solana", name: "SOL", image: URL(string: "https://code.s3.yandex.net/Mobile/iOS/Currencies/Solana_(SOL).png")!),
        Currency(id: "7", title: "Ethereum", name: "ETH", image: URL(string: "https://code.s3.yandex.net/Mobile/iOS/Currencies/Ethereum_(ETH).png")!),
        Currency(id: "1", title: "Cardano", name: "ADA", image: URL(string: "https://code.s3.yandex.net/Mobile/iOS/Currencies/Cardano_(ADA).png")!),
        Currency(id: "0", title: "Shiba Inu", name: "SHIB", image: URL(string: "https://code.s3.yandex.net/Mobile/iOS/Currencies/Shiba_Inu_(SHIB).png")!)
    ]
}
#endif
