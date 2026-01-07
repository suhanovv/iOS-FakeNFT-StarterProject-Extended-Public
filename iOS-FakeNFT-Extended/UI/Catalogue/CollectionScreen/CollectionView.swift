//
//  CollectionView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Diana Viter on 09.12.2025.
//

import SwiftUI
import Kingfisher

struct CollectionView: View {

    // MARK: - Properties

    @StateObject private var viewModel: CollectionViewModel

    private let columns = Array(repeating: GridItem(spacing: 9), count: 3)
    @Environment(Coordinator.self) private var coordinator

    // MARK: - Init

    init(
        collectionId: String,
        collectionService: CollectionServiceProtocol,
        orderService: OrderServiceProtocol? = nil
    ) {
        _viewModel = StateObject(
            wrappedValue: CollectionViewModel(
                collectionId: collectionId,
                collectionService: collectionService,
                orderService: orderService
            )
        )
    }

    // MARK: - Body

    var body: some View {
        Group {
            if let collection = viewModel.collection {
                contentView(collection: collection)
            } else {
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(.ypWhite)
            }
        }
        .toolbar(.hidden, for: .tabBar)
        .task {
            await viewModel.load()
        }
    }

    // MARK: - Views

    private func contentView(collection: CollectionDTO) -> some View {
        VStack {
            headerImage(coverURL: collection.cover)
            collectionInfoSection(collection: collection)
        }
        .ignoresSafeArea(edges: .top)
        .background(.ypWhite)
    }

    private func headerImage(coverURL: URL) -> some View {
        KFImage(coverURL)
            .resizable()
            .scaledToFit()
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .padding(.bottom)
    }

    private func collectionInfoSection(collection: CollectionDTO) -> some View {
        VStack(alignment: .leading) {
            collectionTextBlock(collection: collection)

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

    private func collectionTextBlock(collection: CollectionDTO) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(collection.name.capitalized)
                .font(.system(size: 22, weight: .bold))
                .tracking(0.2)
                .padding(.bottom, 8)

            authorSection(collection: collection)

            Text(collection.description.sentenceCase())
                .font(.system(size: 13))
                .tracking(0.2)
                .padding(.bottom)
        }
    }

    private func authorSection(collection: CollectionDTO) -> some View {
        let fallbackURL = URL(string: "https://practicum.yandex.ru/ios-developer/")
        let url = collection.website ?? fallbackURL

        return HStack {
            Text("Автор коллекции:")
                .font(.system(size: 13))
                .tracking(0.2)

            if let url {
                Button {
                    coordinator.push(.webView(url: url))
                } label: {
                    Text(collection.author)
                        .font(.system(size: 13))
                        .tracking(0.2)
                }
                .tint(.blue)
            } else {
                Text(collection.author)
                    .font(.system(size: 13))
                    .tracking(0.2)
            }
        }
    }

    private var nftGrid: some View {
        LazyVGrid(columns: columns, alignment: .leading, spacing: 16) {
            ForEach(viewModel.nfts) { nft in
                NavigationLink {
                    NftDetailBridgeView(nftId: nft.id)
                        .navigationBarBackButtonHidden(true)
                        .toolbar(.hidden, for: .navigationBar)
                } label: {
                    NftCellView(
                        nftId: nft.id,
                        name: nft.name,
                        price: nft.price,
                        rating: nft.rating,
                        imageURL: nft.images.first,
                        isFavorite: false,
                        isInCart: viewModel.isInCart(nft.id),
                        onFavoriteTap: {},
                        onCartTap: {
                            Task {
                                await viewModel.toggleCart(nftId: nft.id)
                            }
                        }
                    )
                }
                .buttonStyle(.plain)
            }
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
            collectionId: MockData.peachCollection.id,
            collectionService: MockCollectionNftsService()
        )
    }
}

