//
//  MyNFTView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Ди Di on 12/12/25.
//

import SwiftUI

struct MyNFTView: View {
    let nfts: [NftItem]
    
    @AppStorage(StorageKeys.favouriteNFTIds) private var favouritesMarker: Data = Data()
    @AppStorage("nft_sort_type") private var sortType: NftSortType = .byName
    
    @State private var isNftMenuPresented = false
    @State private var viewModel = MyNFTViewModel()
    
    @Environment(Coordinator.self) private var coordinator
    
    private var sortedNfts: [NftItem] {
        viewModel.sortedNFTs(from: nfts, sortType: sortType)
    }
    
    private var favouriteIds: Set<String> {
        viewModel.favouriteIds(from: favouritesMarker)
    }
    
    var body: some View {
        Group {
            if sortedNfts.isEmpty {
                MyNFTEmptyView()
            } else {
                List {
                    ForEach(sortedNfts) { nft in
                        MyNFTCell(
                            nft: nft,
                            rating: nft.rating ?? 0,
                            isFavourite: favouriteIds.contains(nft.id),
                            onLikeTap: {
                                FavouritesStorage.toggle(nft.id)
                            }
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
                .padding(.vertical, 20)
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .tabBar)
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
                sortType = .byPrice
            }
            
            Button(Constants.sortByRating) {
                sortType = .byRating
            }
            
            Button(Constants.sortByName) {
                sortType = .byName
            }
            
            Button(Constants.close, role: .cancel) {}
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
        MyNFTView(nfts: ProfileViewMock.mockNFTs)
    }
}

