//
//  StatisticsUserCollectionScreenView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Вадим Суханов on 10.12.2025.
//
import SwiftUI

struct StatisticsUserCollectionScreenView: View {
    enum ScreenState {
        case loading
        case loaded
        case initial
        case error
    }
    
    @State private var viewModel: ViewModel
    
    init(viewModel: StatisticsUserCollectionScreenView.ViewModel) {
        self.viewModel = viewModel
    }
    
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
        .overlay {
            ZStack {
                Text(Constants.noNftTitle)
                    .font(.system(size: 17, weight: .bold))
                    .opacity(viewModel.isCollectionEmpty ? 1 : 0)
                ProgressBarView(isActive: viewModel.state == .loading)
                
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

private enum Constants {
    static let noNftTitle = NSLocalizedString("UserCollection.noNft.title", comment: "")
    static let screenNftTitle = NSLocalizedString("UserCollection.screen.title", comment: "")
}
