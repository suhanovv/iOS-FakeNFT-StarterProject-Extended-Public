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
    @StateObject private var viewModel = CatalogueViewModel()
    
    @AppStorage(Constants.sortOptionStorageKey)
    private var storedSortOption: CollectionsSortOption = .nftCount
    
    @State private var isSortDialogPresented = false
    
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
    
    private var collectionsScrollView: some View {
        ScrollView {
            VStack(spacing: 24) {
                ForEach(viewModel.collections) { collection in
                    NavigationLink {
                        CollectionView(
                            viewModel: CollectionViewModel(collection: collection)
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
    NavigationStack {
        CatalogueView()
    }
}
