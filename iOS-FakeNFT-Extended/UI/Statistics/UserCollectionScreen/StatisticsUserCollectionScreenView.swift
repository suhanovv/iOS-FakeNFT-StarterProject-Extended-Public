//
//  StatisticsUserCollectionScreenView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Вадим Суханов on 10.12.2025.
//
import SwiftUI

struct StatisticsUserCollectionScreenView: View {
    @State private var viewModel: ViewModel
    
    init(userId: String, isEmpty: Bool = false) {
        self.viewModel = ViewModel(userId: userId, isEmpty: isEmpty)
    }
    
    var body: some View {
        ScrollView(.vertical) {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 108))]) {
                ForEach(viewModel.collection) { nft in
                    NftCardView(
                        viewModel:
                            .init(
                                nft: nft,
                                isLiked: viewModel.isLiked(nftId: nft.id),
                                isInCart: viewModel.isInCart(nftId: nft.id)
                            )
                    )
                }
            }
        }
        .overlay {
            ZStack {
                Text("У пользователя еще нет NFT")
                    .font(.system(size: 17, weight: .bold))
                    .opacity(viewModel.isCollectionEmpty ? 1 : 0)
                ProgressBarView(isActive: viewModel.state == .loading)
                
            }
        }
        .padding(.horizontal, 16)
        .scrollIndicators(.hidden)
        .task {
            await viewModel.loadData()
        }
    }
}


#Preview("not empty") {
    StatisticsUserCollectionScreenView(userId: UUID().uuidString)
}

#Preview("is empty") {
    StatisticsUserCollectionScreenView(userId: UUID().uuidString, isEmpty: true)
}
