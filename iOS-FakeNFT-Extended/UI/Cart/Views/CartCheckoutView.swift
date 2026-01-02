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
                    .foregroundStyle(.ypBlackUniversal)
            }
            .frame(width: 44, height: 44)

            Spacer()

            Text(String(localized: "Cart.checkout.choosePaymentMethod"))
                .font(.headline)
                .foregroundStyle(.ypBlackUniversal)

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
                        image: currencyIcon(for: currency.name),
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

    private func currencyIcon(for code: String) -> Image {
        switch code.uppercased() {
        case "BTC": Image(.CurrencyIcons.bitcoin)
        case "DOGE": Image(.CurrencyIcons.dogecoin)
        case "USDT": Image(.CurrencyIcons.tether)
        case "APE": Image(.CurrencyIcons.apeCoin)
        case "SOL": Image(.CurrencyIcons.solana)
        case "ETH": Image(.CurrencyIcons.ethereum)
        case "ADA": Image(.CurrencyIcons.cardano)
        case "SHIB": Image(.CurrencyIcons.shibaInu)
        default: Image(systemName: "dollarsign.circle.fill")
        }
    }

    private var bottomBar: some View {
        VStack(spacing: 16) {
            agreementText
            payButton
        }
        .padding()
        .background(.ypLightGray, in: RoundedRectangle(cornerRadius: 12))
    }

    private var agreementText: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(String(localized: "Cart.checkout.agreementText"))
                .font(.footnote)
                .foregroundStyle(.ypBlackUniversal)

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
                .foregroundStyle(.ypWhiteUniversal)
                .frame(maxWidth: .infinity)
                .frame(height: 60)
        }
        .background(.ypBlackUniversal, in: RoundedRectangle(cornerRadius: 16))
        .opacity(viewModel.selectedCurrency == nil ? 0.5 : 1)
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

#Preview("Default") {
    let mockServices = ServicesAssembly(
        networkClient: DefaultNetworkClient(),
        nftStorage: NftStorageImpl()
    )
    let viewModel = CartCheckoutView.ViewModel(
        currencyService: mockServices.currencyService,
        paymentService: mockServices.paymentService
    )
    return CartCheckoutView(
        viewModel: viewModel,
        onBack: {},
        onPaymentSuccess: {},
        onAgreementTap: {}
    )
}
