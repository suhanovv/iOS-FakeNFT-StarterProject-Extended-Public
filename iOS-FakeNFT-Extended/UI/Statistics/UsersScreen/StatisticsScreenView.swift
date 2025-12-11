//
//  StatisticsScreenView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Вадим Суханов on 08.12.2025.
//

import SwiftUI

struct StatisticsScreenView: View {
    @Environment(Coordinator.self) var coordinator
    @State private var viewModel: ViewModel
    @State private var isSortOptionsPresented = false
    
    init() {
        _viewModel = State(initialValue: .init(users: (1...10).map { _ in User.makeFakeUser() }))
    }
    
    // MARK: - Body
    var body: some View {
        VStack {
            topBar
            content
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
            SortingToolbarButtonView(viewModel: $viewModel)
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

#Preview {
    StatisticsScreenView().environment(Coordinator())
}
