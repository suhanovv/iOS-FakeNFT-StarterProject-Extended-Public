//
//  StatisticsScreenView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Вадим Суханов on 08.12.2025.
//

import SwiftUI

struct StatisticsScreenView: View {
    enum ScreenState {
        case loading
        case loaded
        case error
    }
    
    @AppStorage(AppStorageKeys.usersSortBy) private var sortOrder: UsersSortType = .rating
    @Environment(Coordinator.self) var coordinator
    @Bindable var viewModel: StatisticsScreenView.ViewModel
    @State private var isSortOptionsPresented = false

    // MARK: - Body
    var body: some View {
        VStack {
            topBar
            content
        }
        .overlay {
            ProgressBarView(isActive: viewModel.state == .loading)
        }
        .task {
            await viewModel.loadFirstPage(orderBy: sortOrder)
        }
        // hack for hiding horizontal tabbar bar 1px separator
        .padding(.vertical, 1)
        .padding(.horizontal, 16)
        .background(.ypWhite)
    }
    
    // MARK: - Views
    private var topBar: some View {
        HStack {
            Spacer()
            SortingToolbarButtonView(viewModel: viewModel, sortOrder: $sortOrder)
        }
        .frame(height: 42)
        .background(.ypWhite)
    }
    
    private var content: some View {
        List {
            ForEach(viewModel.users.indices, id: \.self) { idx in
                let user = viewModel.users[idx]
                StatisticsUserListCellView(
                    rowNumber: idx + 1,
                    userName: user.name,
                    rating: user.rating,
                    avatarUrl: user.avatar)
                .task {
                    if idx != viewModel.users.count - 3 {
                        return
                    }
                    await viewModel.loadNextPage(orderBy: sortOrder)
                }
                .onTapGesture {_ in
                    coordinator.push(.userCard(userId: user.id))
                }
            }
        }
        .listStyle(.plain)
        .listRowSpacing(8)
        .scrollIndicators(.hidden)
        .scrollContentBackground(.hidden)
    }
}
