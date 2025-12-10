//
//  CatalogueCellView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Diana Viter on 09.12.2025.
//


import SwiftUI

// MARK: - CatalogueCellView

struct CatalogueCellView: View {
    
    // MARK: - Properties
    
    let collection: CollectionDTO
    
    // MARK: - Body
    
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

// MARK: - Preview_CatalogueCellView

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
