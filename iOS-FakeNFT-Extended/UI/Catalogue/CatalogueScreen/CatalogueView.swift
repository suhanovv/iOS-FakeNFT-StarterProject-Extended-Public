//
//  CatalogueView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Diana Viter on 09.12.2025.
//

import SwiftUI

struct CatalogueView: View {
    
    // MARK: - Properties
    
    @Environment(ServicesAssembly.self) private var services
    @StateObject private var viewModel = CatalogueViewModel()
    
    @AppStorage("catalogueSortOption")
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
            "Сортировка",
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
            Button("По названию") {
                storedSortOption = .name
                viewModel.setSortOption(.name)
            }
            
            Button("По количеству NFT") {
                storedSortOption = .nftCount
                viewModel.setSortOption(.nftCount)
            }
            
            Button("Закрыть", role: .cancel) {}
        }
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        CatalogueView()
    }
}
