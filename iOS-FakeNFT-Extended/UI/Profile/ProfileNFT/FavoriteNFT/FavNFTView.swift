//
//  FavNFTView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Ди Di on 12/12/25.
//

import SwiftUI

struct FavNFTView: View {
    @AppStorage(StorageKeys.favouriteNFTIds) private var favs: Data = Data()
    @State private var viewModel = FavNFTViewModel()
    @Environment(\.dismiss) private var dismiss
    
    let allNFTs: [NftItem]
    
    private var favouriteIds: [String] {
        viewModel.favouriteIds(from: favs)
    }
    
    private var favouriteNFTs: [NftItem] {
        viewModel.favouriteNFTs(
            allNFTs: allNFTs,
            favouriteIds: favouriteIds
        )
    }
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        Group {
            if favouriteNFTs.isEmpty {
                FavNFTEmptyView()
            } else {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(favouriteNFTs) { nft in
                            FavNFTCell(
                                nft: nft,
                                rating: nft.rating ?? 0,
                                isFavourite: true,
                                onLikeTap: {
                                    favs = viewModel.removeFavourite(nft.id, from: favs)
                                }
                            )
                        }
                    }
                    .padding(.vertical, 20)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(.hidden, for: .tabBar)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(.ypBlack)
                }
            }
            
            if !favouriteNFTs.isEmpty {
                ToolbarItem(placement: .principal) {
                    Text(Constants.favouriteNFT)
                        .font(Font(UIFont.bodyBold))
                }
            }
        }
    }
}

private enum Constants {
    static let favouriteNFT = NSLocalizedString("Profile.favouriteNFT", comment: "")
}

// MARK: - Preview_FavNFTView
#Preview {
    NavigationStack {
        FavouritesPreview()
    }
}
struct FavouritesPreview: View {
    @AppStorage(StorageKeys.favouriteNFTIds) private var favs: Data = Data()
    
    init() {
        let ids = ["1", "2", "3"]
        favs = (try? JSONEncoder().encode(ids)) ?? Data()
    }
    
    var body: some View {
        FavNFTView(allNFTs: ProfileViewMock.mockNFTs)
    }
}
