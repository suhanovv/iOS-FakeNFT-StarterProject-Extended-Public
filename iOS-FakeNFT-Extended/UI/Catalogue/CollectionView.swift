//
//  CollectionView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Diana Viter on 09.12.2025.
//

import SwiftUI
import WebKit

struct CollectionView: View {
    @Environment(\.dismiss) private var dismiss

    let collection: CollectionDTO
    let nfts: [Nft]
    
    init(
        collection: CollectionDTO = MockData.peachCollection,
        nfts: [Nft] = MockData.nfts
    ) {
        self.collection = collection
        self.nfts = nfts
    }

    private let columns = Array(repeating: GridItem(spacing: 9), count: 3)

    var body: some View {
        ZStack(alignment: .topLeading) {
            VStack {
                Image(.collectionRow)
                    .resizable()
                    .scaledToFit()
                    .clipShape(
                        RoundedRectangle(
                            cornerRadius: 12,
                            style: .continuous
                        )
                    )
                    .padding(.bottom)

                VStack(alignment: .leading) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(collection.name)
                            .font(.init(UIFont.headline3))
                            .tracking(0.2)
                            .padding(.bottom, 8)

                        if let authorName = collection.authorName,
                           let website = collection.website {
                            HStack {
                                Text("Автор коллекции:")
                                    .font(Font(UIFont.caption2))
                                    .tracking(0.2)

                                NavigationLink {
                                    WebViewScreen(url: website)
                                } label: {
                                    Text(authorName)
                                        .font(Font(UIFont.caption2))
                                        .tracking(0.2)
                                        .foregroundStyle(.blue)
                                }
                            }
                        }

                        Text(collection.description)
                            .font(Font(UIFont.caption2))
                            .tracking(0.2)
                            .padding(.bottom)
                    }

                    ScrollView {
                        LazyVGrid(columns: columns, alignment: .leading, spacing: 16) {
                            ForEach(nfts) { nft in
                                NavigationLink {
                                    NftDetailBridgeView()
                                } label: {
                                    NftCellView(
                                        name: nft.name,
                                        price: nft.price,
                                        rating: nft.rating,
                                        imageURL: nft.images.first,
                                        isFavorite: false,
                                        isInCart: false
                                    )
                                }
                                .buttonStyle(.plain)
                            }
                        }
                    }
                }
                .padding(.horizontal)
            }
            .ignoresSafeArea(edges: .top)
            
            Button(action: { dismiss() }) {
                Image(systemName: "chevron.left")
                    .font(.system(size: 22, weight: .medium))
                    .foregroundColor(.black)
                    .padding()
            }
        }
        .toolbar(.hidden, for: .tabBar)
    }
}


#Preview {
    NavigationStack {
        CollectionView()
    }
}
