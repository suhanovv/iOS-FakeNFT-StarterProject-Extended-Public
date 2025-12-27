//
//  CatalogueView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Diana Viter on 09.12.2025.
//

import SwiftUI

extension CatalogueView {
    enum Constants {
        static let sortDialogTitle = "Сортировка"
        static let sortByNameTitle = "По названию"
        static let sortByNftCountTitle = "По количеству NFT"
        static let closeTitle = "Закрыть"
        static let sortOptionStorageKey = "catalogueSortOption"
    }
}

struct CatalogueView: View {
    
    // MARK: - Properties
    
    @Environment(ServicesAssembly.self) private var services
    @Environment(Coordinator.self) private var coordinator
    @StateObject private var viewModel: CatalogueViewModel
    
    @AppStorage(Constants.sortOptionStorageKey)
    private var storedSortOption: CollectionsSortOption = .nftCount
    
    @State private var isSortDialogPresented = false
    
    // MARK: - Init
    
    init(collectionsService: CollectionsServiceProtocol) {
        _viewModel = StateObject(wrappedValue: CatalogueViewModel(collectionsService: collectionsService))
    }
    
    // MARK: - Body
    
    var body: some View {
        VStack(spacing: .zero) {
            headerBar
            collectionsScrollView
        }
        .task {
            viewModel.setSortOption(storedSortOption)
            await viewModel.load()
        }
        .confirmationDialog(
            Constants.sortDialogTitle,
            isPresented: $isSortDialogPresented,
            titleVisibility: .visible
        ) {
            sortOptionsDialog
        }
    }
    
    // MARK: - Views
    
    private var headerBar: some View {
        HStack {
            Spacer()
            
            Button {
                isSortDialogPresented = true
            } label: {
                Image(.CommonIcons.sort)
                    .foregroundStyle(.ypBlackUniversal)
            }
            .padding(.trailing, 16)
            .padding(.top, 16)
        }
    }
    
    @ViewBuilder
    private var collectionsScrollView: some View {
        switch viewModel.state {
        case .initial, .loading:
            ProgressView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
        case .loaded:
            ScrollView {
                VStack(spacing: 24) {
                    ForEach(viewModel.collections) { collection in
                        Button {
                            coordinator.push(.collection(id: collection.id))
                        } label: {
                            CatalogueCellView(collection: collection)
                                .contentShape(Rectangle())
                                .foregroundColor(.primary)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.top, 16)
                .padding(.bottom, 16)
            }
            
        case .error(let message):
            Text(message)
                .font(.caption)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .multilineTextAlignment(.center)
                .padding()
        }
    }
    
    private var sortOptionsDialog: some View {
        Group {
            Button(Constants.sortByNameTitle) {
                storedSortOption = .name
                viewModel.setSortOption(.name)
            }
            
            Button(Constants.sortByNftCountTitle) {
                storedSortOption = .nftCount
                viewModel.setSortOption(.nftCount)
            }
            
            Button(Constants.closeTitle, role: .cancel) {}
        }
    }
}

// MARK: - Preview

#Preview {
    let services = ServicesAssembly(
        networkClient: DefaultNetworkClient(),
        nftStorage: NftStorageImpl()
    )
    
    return NavigationStack {
        CatalogueView(collectionsService: services.collectionsService)
            .environment(services)
    }
}
