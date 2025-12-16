//
//  CollectionView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Diana Viter on 09.12.2025.
//


import SwiftUI
import WebKit

struct CollectionView: View {

    // MARK: - Properties

    @ObservedObject var viewModel: CollectionViewModel

    private let columns = Array(repeating: GridItem(spacing: 9), count: 3)
    @Environment(\.dismiss) private var dismiss

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
        Image(.collectionRow)
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
            Text(viewModel.collection.name)
                .font(.init(UIFont.headline3))
                .tracking(0.2)
                .padding(.bottom, 8)

            authorSection

            Text(viewModel.collection.description)
                .font(Font(UIFont.caption2))
                .tracking(0.2)
                .padding(.bottom)
        }
    }

    private var authorSection: some View {
        Group {
            if let authorName = viewModel.collection.authorName,
               let website = viewModel.collection.website {

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
            ForEach(viewModel.nfts) { nft in
                NavigationLink {
                    NftDetailBridgeView()
                } label: {
                    NftCellView(
                        name: nft.name,
                        price: Decimal(nft.price),
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

#Preview {
    NavigationStack {
        CollectionView(
            viewModel: CollectionViewModel(
                collection: MockData.peachCollection,
                nftService: MockNftService()
            )
        )
    }
}
