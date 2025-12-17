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
