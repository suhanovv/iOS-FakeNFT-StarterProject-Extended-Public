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
            AsyncImage(url: collection.cover) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                Color.gray.opacity(0.1)
            }
            .frame(height: 140, alignment: .top)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            
            Text("\(collection.name.capitalized) (\(collection.nftCount))")
                .font(.init(UIFont.bodyBold))
        }
        .padding(.horizontal)
        
    }
}

// MARK: - Preview_CatalogueCellView

#Preview {
<<<<<<< HEAD
    if let url = URL(string: "https://example.com/peach.png") {
        CatalogueCellView(
            collection: CollectionDTO(
                id: "1",
                name: "Peach",
                cover: url,
                description: "Sample description",
                author: "Peach Author",
                website: nil,
                nftIds: ["1", "2", "3"]
            )
        )
    } else {
        Text("Invalid preview URL")
    }
=======
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
>>>>>>> 125d0bf (chore: small cleanup across files based on review comments)
}
