//
//  StatisticsUserCollectionScreenView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Вадим Суханов on 10.12.2025.
//
import SwiftUI

struct StatisticsUserCollectionScreenView: View {
    @Bindable var viewModel: ViewModel
    
    var body: some View {
        ScrollView(.vertical) {
            LazyVGrid(
                columns: [GridItem(.adaptive(minimum: NftCardView.width))]
            ) {
                ForEach(viewModel.collection) { nft in
                    NftCardView(
                        nft: nft,
                        isLiked: viewModel.isLiked(nftId: nft.id),
                        isInCart: viewModel.isInCart(nftId: nft.id),
                        likeTapAction: {
                            Task { await viewModel.toggleLike(nftId: nft.id) }
                        },
                        buyTapAction: {
                            Task { await viewModel.toggleInCart(nftId: nft.id) }
                        }
                    )
                }
            }
        }
        .opacity(viewModel.state == nil ? 0 : 1)
        .overlay {
            ZStack {
                Text(Constants.noNftTitle)
                    .font(.system(size: 17, weight: .bold))
                    .opacity(viewModel.isCollectionEmpty ? 1 : 0)
                ProgressBarView(isActive: viewModel.state == .loading)
            }
        }
        .alert(
            Constants.errorTitle,
            isPresented: .constant(viewModel.state?.isError ?? false),
            presenting: viewModel.state
        ) { state in
            Button(Constants.errorButtonCancelTitle, role: .cancel) {
                viewModel.setState(.loaded)
            }
            Button(Constants.errorButtonRetryTitle) {
                Task {
                    if case .error(let operation) = viewModel.state {
                        await viewModel.retryOperation(operation)
                    }
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.top, 20)
        .background(.ypWhite)
        .scrollIndicators(.hidden)
        .navigationTitle(Constants.screenNftTitle)
        .task {
            await viewModel.loadData()
        }
    }
}
