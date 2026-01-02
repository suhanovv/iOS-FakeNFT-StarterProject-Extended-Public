//
//  CartContainerView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Pavel Komarov on 02.01.2026.
//

import SwiftUI

struct CartContainerView: View {
    @Environment(ServicesAssembly.self) private var services
    @Environment(Coordinator.self) private var coordinator

    @State private var cartViewModel: CartView.ViewModel?
    @State private var checkoutViewModel: CartCheckoutView.ViewModel?
    @State private var showCheckout = false
    @State private var showPaymentSuccess = false

    var body: some View {
        NavigationStack {
            if let viewModel = cartViewModel {
                CartView(
                    viewModel: viewModel,
                    onPayment: {
                        setupCheckoutViewModel()
                        showCheckout = true
                    }
                )
                .navigationDestination(isPresented: $showCheckout) {
                    if let checkoutVM = checkoutViewModel {
                        CartCheckoutView(
                            viewModel: checkoutVM,
                            onBack: { showCheckout = false },
                            onPaymentSuccess: { showPaymentSuccess = true },
                            onAgreementTap: { openAgreement() }
                        )
                        .navigationBarBackButtonHidden(true)
                    }
                }
            } else {
                ProgressView()
            }
        }
        .fullScreenCover(isPresented: $showPaymentSuccess) {
            CartPaymentSuccessView(
                onReturn: {
                    showPaymentSuccess = false
                    showCheckout = false
                    Task {
                        cartViewModel?.clearCartAfterPayment()
                        await cartViewModel?.loadCart()
                    }
                }
            )
        }
        .task {
            setupCartViewModel()
        }
    }

    private func setupCartViewModel() {
        cartViewModel = CartView.ViewModel(
            orderService: services.orderService,
            nftService: services.nftService
        )
    }

    private func setupCheckoutViewModel() {
        checkoutViewModel = CartCheckoutView.ViewModel(
            currencyService: services.currencyService,
            paymentService: services.paymentService
        )
    }

    private func openAgreement() {
        if let url = URL(string: "https://yandex.ru/legal/practicum_termsofuse/") {
            coordinator.push(.webView(url: url))
        }
    }
}
