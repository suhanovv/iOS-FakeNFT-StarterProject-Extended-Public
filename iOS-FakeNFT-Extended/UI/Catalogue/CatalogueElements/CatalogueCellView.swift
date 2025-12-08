//
//  CatalogueCellView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Diana Viter on 05.12.2025.
//

import SwiftUI

struct CatalogueCellView: View {
    let collection: CollectionDTO
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Image(.collectionRow)
                .resizable()
                .scaledToFill()
                .frame(height: 140, alignment: .top)
                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
            
            Text("\(collection.name) (\(collection.nftIds.count))")
                .font(.init(UIFont.bodyBold))
        }
        .padding(.horizontal)
    }
}

#Preview {
    CatalogueCellView(
        collection: CollectionDTO(
            id: "1",
            name: "Peach",
            cover: URL(string: "https://example.com/peach.png")!,
            description: "Sample description",
            authorId: "author-1",
            authorName: "Peach Author",
            website: nil,
            nftIds: ["1", "2", "3"]
        )
    )
}

