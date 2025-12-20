//
//  MyNFTView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Ди Di on 12/12/25.
//

import SwiftUI

struct MyNFTView: View {
    @AppStorage(AppStorageNftKeys.nftSortBy)
    private var nftSortOrder: NftSortType = .byName
    
    @State private var isNftMenuPresented = false
    @State private var viewModel: MyNFTViewModel
    
    init(viewModel: MyNFTViewModel) {
        _viewModel = State(initialValue: viewModel)
    }
    
    private var sortedNfts: [Nft] {
        viewModel.sortedNFTs(
            from: viewModel.nfts,
            sortType: nftSortOrder
        )
    }
    
    var body: some View {
        content
            .navigationBarBackButtonHidden(true)
            .toolbarBackground(.hidden, for: .bottomBar)
            .toolbar {
                if !sortedNfts.isEmpty {
                    ToolbarItem(placement: .principal) {
                        Text(Constants.myNFT)
                            .font(Font(UIFont.bodyBold))
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            isNftMenuPresented = true
                        } label: {
                            Image(.CommonIcons.sort)
                                .foregroundColor(.ypBlack)
                        }
                    }
                }
            }
            .confirmationDialog(
                Text(Constants.sortNFT),
                isPresented: $isNftMenuPresented,
                titleVisibility: .visible
            ) {
                Button(Constants.sortByPrice) {
                    nftSortOrder = .byPrice
                }
                
                Button(Constants.sortByRating) {
                    nftSortOrder = .byRating
                }
                
                Button(Constants.sortByName) {
                    nftSortOrder = .byName
                }
                
                Button(Constants.close, role: .cancel) {}
            }
            .task {
                await viewModel.load()
            }
    }
    
    @ViewBuilder
    private var content: some View {
        if viewModel.isLoading {
            ProgressBarView(isActive: true)
        } else if sortedNfts.isEmpty {
            MyNFTEmptyView()
        } else {
            List {
                ForEach(sortedNfts, id: \.id) { nft in
                    MyNFTCell(
                        nft: nft,
                        rating: nft.rating ?? 0,
                        isFavourite: false,
                        onLikeTap: {}
                    )
                    .padding(.leading, 16)
                    .padding(.trailing, 39)
                    .padding(.vertical, 16)
                    .listRowInsets(EdgeInsets())
                    .listRowSeparator(.hidden)
                }
            }
            .listStyle(.plain)
            .navigationBarTitleDisplayMode(.inline)
            .ignoresSafeArea(.container, edges: .bottom)
        }
        
    }
}

private enum Constants {
    static let myNFT = NSLocalizedString("Profile.myNFT", comment: "")
    static let sortNFT = NSLocalizedString("Profile.sorting.title", comment: "")
    static let sortByPrice = NSLocalizedString("Profile.sorting.byPriceButton", comment: "")
    static let sortByRating = NSLocalizedString("Profile.sorting.byRatingButton", comment: "")
    static let sortByName = NSLocalizedString("Profile.sorting.byNameButton", comment: "")
    static let close = NSLocalizedString("Profile.sorting.closeButton", comment: "")
}

// MARK: - Preview_MyNFTView
#Preview {
    NavigationStack {
        MyNFTView(
            viewModel: MyNFTViewModel(
                nftService: PreviewNftService(),
                nftIds: ["1", "2"]
            )
        )
    }
}
