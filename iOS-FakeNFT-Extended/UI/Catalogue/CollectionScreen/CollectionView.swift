//
//  CollectionView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Diana Viter on 09.12.2025.
//


import SwiftUI
import WebKit
import Kingfisher

struct CollectionView: View {
    
    // MARK: - Properties
    
    @StateObject private var viewModel: CollectionViewModel
    
    private let columns = Array(repeating: GridItem(spacing: 9), count: 3)
    @Environment(\.dismiss) private var dismiss
    
    // MARK: - Init
    
    init(
        collection: CollectionDTO,
        collectionService: CollectionServiceProtocol
    ) {
        _viewModel = StateObject(
            wrappedValue: CollectionViewModel(
                collection: collection,
                collectionService: collectionService
            )
        )
    }
    
    // MARK: - Body
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            contentView
            backButton
        }
        .toolbar(.hidden, for: .tabBar)
        .task {
            await viewModel.load()
        }
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
        KFImage(viewModel.collection.cover)
            .resizable()
            .scaledToFit()
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .padding(.bottom)
    }
    
    private var collectionInfoSection: some View {
        VStack(alignment: .leading) {
            collectionTextBlock
            
            switch viewModel.state {
            case .initial, .loading:
                ProgressView()
                    .frame(maxWidth: .infinity, minHeight: 120)
                ScrollView { nftGrid }
                
            case .loaded:
                ScrollView { nftGrid }
                
            case .error(let message):
                Text(message)
                    .font(.caption)
                    .frame(maxWidth: .infinity, minHeight: 120)
            }
        }
        .padding(.horizontal)
    }
    
    private var collectionTextBlock: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(viewModel.collection.name.capitalized)
                .font(.init(UIFont.headline3))
                .tracking(0.2)
                .padding(.bottom, 8)
            
            authorSection
            
            Text(viewModel.collection.description.sentenceCase())
                .font(Font(UIFont.caption2))
                .tracking(0.2)
                .padding(.bottom)
        }
    }
    
    private var authorSection: some View {
        let fallbackURL = URL(string: "https://practicum.yandex.ru/ios-developer/")
        let url = viewModel.collection.website ?? fallbackURL

        return HStack {
            Text("Автор коллекции:")
                .font(Font(UIFont.caption2))
                .tracking(0.2)

            if let url {
                NavigationLink {
                    WebViewScreen(url: url)
                } label: {
                    Text(viewModel.collection.author)
                        .font(Font(UIFont.caption2))
                        .tracking(0.2)
                }
                .tint(.blue)
            } else {
                Text(viewModel.collection.author)
                    .font(Font(UIFont.caption2))
                    .tracking(0.2)
            }
        }
    }

    
    private var nftGrid: some View {
        LazyVGrid(columns: columns, alignment: .leading, spacing: 16) {
            ForEach(viewModel.nfts) { nft in
                NavigationLink {
                    NftDetailBridgeView(nftId: nft.id)
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

// MARK: - Preview

final class MockCollectionNftsService: CollectionServiceProtocol {
    func fetchCollection(id: String) async throws -> CollectionDTO {
        MockData.peachCollection
    }
    
    func loadNfts(ids: [String]) async throws -> [Nft] {
        MockData.nfts.filter { ids.contains($0.id) }
    }
}

#Preview {
    NavigationStack {
        CollectionView(
            collection: MockData.peachCollection,
            collectionService: MockCollectionNftsService()
        )
    }
}
