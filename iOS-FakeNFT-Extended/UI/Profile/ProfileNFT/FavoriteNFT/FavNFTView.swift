//
//  FavNFTView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Ди Di on 12/12/25.
//

import SwiftUI

struct FavNFTView: View {
    @State private var viewModel: FavNFTViewModel
    
    init(viewModel: FavNFTViewModel) {
        _viewModel = State(initialValue: viewModel)
    }
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        content
            .task {
                await viewModel.load()
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarTitleDisplayMode(.inline)
            .ignoresSafeArea(.container, edges: .bottom)
            .toolbarBackground(.hidden, for: .bottomBar)
            .toolbar {
                if !viewModel.nfts.isEmpty {
                    ToolbarItem(placement: .principal) {
                        Text(Constants.favouriteNFT)
                            .font(Font(UIFont.bodyBold))
                    }
                }
            }
    }
    
    @ViewBuilder
    private var content: some View {
        if viewModel.isLoading {
            ProgressBarView(isActive: true)
        } else if viewModel.nfts.isEmpty {
            FavNFTEmptyView()
        } else {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(viewModel.nfts) { nft in
                        FavNFTCell(
                            nft: nft,
                            rating: nft.rating ?? 0,
                            isFavourite: true,
                            onLikeTap: {
                                viewModel.nfts.removeAll { $0.id == nft.id }
                            }
                        )
                    }
                }
                .padding(.vertical, 20)
            }
        }
        
    }
}

private enum Constants {
    static let favouriteNFT = NSLocalizedString("Profile.favouriteNFT", comment: "")
}

// MARK: - Preview_FavNFTView
#if DEBUG
actor PreviewNftService: NftService {
    func loadNft(id: String) async throws -> Nft {
        Nft(
            id: id,
            images: [
                URL(string: "https://code.s3.yandex.net/Mobile/iOS/NFT/Pink/Lilo/1.png")!
            ],
            rating: 4,
            price: 12.5,
            name: "Preview NFT",
            author: "Preview",
            createdAt: nil,
            description: "Preview description"
        )
    }
}
#endif
#Preview {
    NavigationStack {
        FavNFTView(
            viewModel: FavNFTViewModel(
                nftService: PreviewNftService(),
                nftIds: ["1", "2", "3"]
            )
        )
    }
}
