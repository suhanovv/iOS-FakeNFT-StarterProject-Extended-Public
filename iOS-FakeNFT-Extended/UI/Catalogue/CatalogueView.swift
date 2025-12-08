//
//  CatalogueView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Diana Viter on 05.12.2025.
//

import SwiftUI

struct CatalogueView: View {
    let collections: [CollectionDTO]
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Spacer()
                
                Button {
                    // TODO: сортировка
                } label: {
                    Image("Common Icons/Sort")
                        .renderingMode(.template)
                        .foregroundStyle(.ypBlackUniversal)
                }
                .padding(.trailing, 16)
                .padding(.top, 16)
            }
            
            ScrollView {
                VStack(spacing: 24) {
                    ForEach(collections) { collection in
                        NavigationLink {
                            CollectionView(
                                collection: collection,
                                nfts: []
                            )
                            .navigationBarBackButtonHidden(true)
                        } label: {
                            CatalogueCellView(collection: collection)
                                .contentShape(Rectangle())
                                .foregroundColor(.primary)
                        }
                    }
                }
                .padding(.top, 16)
                .padding(.bottom, 16)
            }
        }
    }
}


#Preview {
    NavigationStack {
        CatalogueView(collections: mockCollections)
    }
}

private let mockCollections: [CollectionDTO] = [
    CollectionDTO(
        id: "1",
        name: "Peach",
        cover: URL(string: "https://example.com/peach.png")!,
        description: "Peach collection",
        authorId: "author-1",
        authorName: "Peach Author",
        website: URL(string: "https://example.com")!,
        nftIds: ["1", "2", "3"]
    ),
    CollectionDTO(
        id: "2",
        name: "Blue",
        cover: URL(string: "https://example.com/blue.png")!,
        description: "Blue collection",
        authorId: "author-2",
        authorName: "Blue Author",
        website: nil,
        nftIds: ["4", "5"]
    )
]
