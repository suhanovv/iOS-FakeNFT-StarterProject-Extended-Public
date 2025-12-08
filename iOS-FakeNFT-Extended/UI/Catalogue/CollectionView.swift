//
//  CollectionView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Diana Viter on 05.12.2025.
//

import SwiftUI
import WebKit

struct CollectionView: View {
    @Environment(\.dismiss) private var dismiss

    let collection: CollectionDTO
    let nfts: [Nft]

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
    }
}



#Preview {
    let collection = CollectionDTO(
        id: "1",
        name: "Peach",
        cover: URL(string: "https://example.com/cover.png")!,
        description: "Персиковый — как облака над закатным солнцем в океане. В этой коллекции совмещены трогательная нежность и живая игривость сказочных зефирных зверей.",
        authorId: "author-1",
        authorName: "John Doe",
        website: URL(string: "https://practicum.yandex.ru/ios-developer/")!,
        nftIds: ["1", "2", "3", "4", "5", "6"]
    )
    
    let nfts: [Nft] = [
        Nft(
            id: "1",
            name: "Archie",
            images: [URL(string: "https://example.com/archie.png")!],
            rating: 3,
            price: 1,
            author: "John Doe",
            website: nil,
            description: "desc",
            createdAt: "2025-01-01"
        ),
        Nft(
            id: "2",
            name: "Ruby",
            images: [URL(string: "https://example.com/ruby.png")!],
            rating: 4,
            price: 1,
            author: "John Doe",
            website: nil,
            description: "desc",
            createdAt: "2025-01-01"
        ),
        Nft(
            id: "3",
            name: "Nacho",
            images: [URL(string: "https://example.com/nacho.png")!],
            rating: 5,
            price: 1,
            author: "John Doe",
            website: nil,
            description: "desc",
            createdAt: "2025-01-01"
        ),
        Nft(
            id: "4",
            name: "Nacho",
            images: [URL(string: "https://example.com/nacho.png")!],
            rating: 5,
            price: 1,
            author: "John Doe",
            website: nil,
            description: "desc",
            createdAt: "2025-01-01"
        ),
        Nft(
            id: "5",
            name: "Nacho",
            images: [URL(string: "https://example.com/nacho.png")!],
            rating: 5,
            price: 1,
            author: "John Doe",
            website: nil,
            description: "desc",
            createdAt: "2025-01-01"
        ),
        Nft(
            id: "6",
            name: "Nacho",
            images: [URL(string: "https://example.com/nacho.png")!],
            rating: 5,
            price: 1,
            author: "John Doe",
            website: nil,
            description: "desc",
            createdAt: "2025-01-01"
        )
    ]
    
    NavigationStack {
        CollectionView(collection: collection, nfts: nfts)
    }
}
