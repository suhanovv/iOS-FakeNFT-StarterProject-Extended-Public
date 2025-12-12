//
//  FavNFTView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Ди Di on 12/12/25.
//

import SwiftUI

struct FavNFTView: View {
    let allNFTs: [NftItem]

    @AppStorage("favorite_nft_ids") private var favs: Data = Data()

    private var favoriteIds: [String] {
        (try? JSONDecoder().decode([String].self, from: favs)) ?? []
    }

    private var favoriteNFTs: [NftItem] {
        allNFTs.filter { favoriteIds.contains($0.id) }
    }

    let columns = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(favoriteNFTs) { nft in
                    FavNFTCell(nft: nft, rating: nft.rating ?? 0)
                }
            }
            .padding(.vertical, 20)
        }
    }
}

// MARK: - Preview_FavNFTView
#Preview {
    NavigationStack {
        FavoritesPreview()
    }
}

struct FavoritesPreview: View {
    @AppStorage("favorite_nft_ids") private var favs: Data = Data()

    init() {
        let ids = ["1", "2", "3"]
        favs = (try? JSONEncoder().encode(ids)) ?? Data()
    }

    var body: some View {
        FavNFTView(allNFTs: ProfileViewMock.mockNFTs)
    }
}
