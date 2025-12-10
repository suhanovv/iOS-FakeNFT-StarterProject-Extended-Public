//
//  CollectionView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Diana Viter on 09.12.2025.
//


import SwiftUI
import WebKit

// MARK: - CollectionView

struct CollectionView: View {
    
    // MARK: - Properties
    
    let collection: CollectionDTO
    let nfts: [Nft]
    
    private let columns = Array(repeating: GridItem(spacing: 9), count: 3)
    @Environment(\.dismiss) private var dismiss
    
    // MARK: - Init
    
    init(
        collection: CollectionDTO = MockData.peachCollection,
        nfts: [Nft] = MockData.nfts
    ) {
        self.collection = collection
        self.nfts = nfts
    }
    
    // MARK: - Body
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            contentView
            backButton
        }
        .toolbar(.hidden, for: .tabBar)
    }
    
    // MARK: - Views
    
    private var contentView: some View {
        VStack {
            headerImage
            collectionInfoSection
        }
        .ignoresSafeArea(edges: .top)
    }
    
    private var headerImage: some View {
        Image(.collectionRow)
            .resizable()
            .scaledToFit()
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
            .padding(.bottom)
    }
    
    private var collectionInfoSection: some View {
        VStack(alignment: .leading) {
            collectionTextBlock
            
            ScrollView {
                nftGrid
            }
        }
        .padding(.horizontal)
    }
    
    private var collectionTextBlock: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(collection.name)
                .font(.init(UIFont.headline3))
                .tracking(0.2)
                .padding(.bottom, 8)
            
            authorSection
            
            Text(collection.description)
                .font(Font(UIFont.caption2))
                .tracking(0.2)
                .padding(.bottom)
        }
    }
    
    private var authorSection: some View {
        Group {
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
        }
    }
    
    private var nftGrid: some View {
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
    
    private var backButton: some View {
        Button(action: { dismiss() }) {
            Image(systemName: "chevron.left")
                .font(.system(size: 22, weight: .medium))
                .foregroundColor(.black)
                .padding()
        }
    }
}

// MARK: - Preview_CollectionView

#Preview {
    NavigationStack {
        CollectionView()
    }
}
