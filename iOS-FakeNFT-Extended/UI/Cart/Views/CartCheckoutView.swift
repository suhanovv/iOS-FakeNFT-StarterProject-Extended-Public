//
//  CartCheckoutView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Pavel Komarov on 02.01.2026.
//

import SwiftUI

struct CartCheckoutView: View {

    // MARK: - Properties

    @Bindable var viewModel: ViewModel
    var onBack: () -> Void
    var onPaymentSuccess: () -> Void
    var onAgreementTap: () -> Void

    private let columns = [
        GridItem(.flexible(), spacing: 8),
        GridItem(.flexible(), spacing: 8)
    ]

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
                    currencyGrid
                    Spacer()
                    bottomBar
                case .error(let message):
                    Spacer()
                    Text(message)
                        .font(.headline)
                        .foregroundStyle(.ypBlackUniversal)
                    Spacer()
                }
            }
        }
        .alert(String(localized: "Cart.checkout.paymentFailed"), isPresented: $viewModel.showPaymentError) {
            Button(String(localized: "Common.cancel"), role: .cancel) {}
            Button(String(localized: "Common.retry")) {
                Task {
                    await viewModel.retryPayment()
                }
            }
            .keyboardShortcut(.defaultAction)
        }
        .onChange(of: viewModel.showPaymentSuccess) { _, success in
            if success {
                onPaymentSuccess()
            }
        }
        .task {
            await viewModel.loadCurrencies()
        }
    }

    // MARK: - Subviews

    private var navigationBar: some View {
        HStack {
            Button(action: onBack) {
                Image(.CommonIcons.chevron)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .foregroundStyle(.ypBlack)
            }
            .frame(width: 44, height: 44)

            Spacer()

            Text(String(localized: "Cart.checkout.choosePaymentMethod"))
                .font(.headline)
                .foregroundStyle(.ypBlack)

            Spacer()

            Color.clear
                .frame(width: 44, height: 44)
        }
        .padding(.horizontal, 8)
    }

    private var currencyGrid: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 7) {
                ForEach(viewModel.currencies) { currency in
                    CartCurrencyCardView(
                        imageURL: currency.image,
                        title: currency.title,
                        code: currency.name,
                        isSelected: viewModel.selectedCurrency?.id == currency.id
                    )
                    .onTapGesture {
                        viewModel.selectedCurrency = currency
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 20)
        }
    }

    private var bottomBar: some View {
        VStack(spacing: 16) {
            agreementText
            payButton
        }
        .padding()
        .background(.ypLightGray, in: UnevenRoundedRectangle(topLeadingRadius: 12, bottomLeadingRadius: 0, bottomTrailingRadius: 0, topTrailingRadius: 12))
    }

    private var agreementText: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(String(localized: "Cart.checkout.agreementText"))
                .font(.footnote)
                .foregroundStyle(.ypBlack)

            Button(action: onAgreementTap) {
                Text(String(localized: "Cart.checkout.userAgreement"))
                    .font(.footnote)
                    .foregroundStyle(.ypBlueUniversal)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var payButton: some View {
        Button {
            Task {
                await viewModel.pay()
            }
        } label: {
            Text(String(localized: "Cart.checkout.payButton"))
                .font(.headline)
                .foregroundStyle(.ypWhite)
                .frame(maxWidth: .infinity)
                .frame(height: 60)
        }
        .background(.ypBlack, in: RoundedRectangle(cornerRadius: 16))
        .disabled(viewModel.selectedCurrency == nil)
    }
}

// MARK: - Currency + Identifiable

extension Currency: Identifiable, Equatable {
    static func == (lhs: Currency, rhs: Currency) -> Bool {
        lhs.id == rhs.id
    }
}

// MARK: - Previews

#if DEBUG

private actor PreviewCurrencyService: CurrencyServiceProtocol {
    var currencies: [Currency] {
        get async throws {
            [
                Currency(id: "0", title: "Shiba_Inu", name: "SHIB", image: URL(string: "https://code.s3.yandex.net/Mobile/iOS/Currencies/Shiba_Inu_(SHIB).png")!),
                Currency(id: "1", title: "Cardano", name: "ADA", image: URL(string: "https://code.s3.yandex.net/Mobile/iOS/Currencies/Cardano_(ADA).png")!),
                Currency(id: "2", title: "Tether", name: "USDT", image: URL(string: "https://code.s3.yandex.net/Mobile/iOS/Currencies/Tether_(USDT).png")!),
                Currency(id: "3", title: "ApeCoin", name: "APE", image: URL(string: "https://code.s3.yandex.net/Mobile/iOS/Currencies/ApeCoin_(APE).png")!),
                Currency(id: "4", title: "Solana", name: "SOL", image: URL(string: "https://code.s3.yandex.net/Mobile/iOS/Currencies/Solana_(SOL).png")!),
                Currency(id: "5", title: "Bitcoin", name: "BITCOIN", image: URL(string: "https://code.s3.yandex.net/Mobile/iOS/Currencies/Bitcoin_(BTC).png")!),
                Currency(id: "6", title: "Dogecoin", name: "DOGECOIN", image: URL(string: "https://code.s3.yandex.net/Mobile/iOS/Currencies/Dogecoin_(DOGE).png")!),
                Currency(id: "7", title: "Ethereum", name: "ETHEREUM", image: URL(string: "https://code.s3.yandex.net/Mobile/iOS/Currencies/Ethereum_(ETH).png")!)
            ]
        }
    }

    subscript(id: String) -> Currency {
        get async throws {
            Currency(id: id, title: "Bitcoin", name: "BITCOIN", image: URL(string: "https://code.s3.yandex.net/Mobile/iOS/Currencies/Bitcoin_(BTC).png")!)
        }
    }
}

private actor PreviewPaymentService: PaymentServiceProtocol {
    func pay(orderId: String, currencyId: String) async throws -> PaymentResult {
        PaymentResult(success: true, orderId: orderId, id: currencyId)
    }
}

private actor PreviewOrderService: OrderServiceProtocol {
    func getOrder() async throws -> Order {
        Order(id: "1", nfts: [])
    }

    func addToCartNft(_ nftId: String) async throws -> Order {
        Order(id: "1", nfts: [nftId])
    }

    func removeFromCartNft(_ nftId: String) async throws -> Order {
        Order(id: "1", nfts: [])
    }

    func clearCart() async throws -> Order {
        Order(id: "1", nfts: [])
    }
}

#Preview("Default") {
    CartCheckoutView(
        viewModel: CartCheckoutView.ViewModel(
            currencyService: PreviewCurrencyService(),
            paymentService: PreviewPaymentService(),
            orderService: PreviewOrderService()
        ),
        onBack: {},
        onPaymentSuccess: {},
        onAgreementTap: {}
    )
}

#endif
