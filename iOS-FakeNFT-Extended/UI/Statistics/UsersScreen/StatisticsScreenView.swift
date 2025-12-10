//
//  StatisticsScreenView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Вадим Суханов on 08.12.2025.
//

import SwiftUI

struct StatisticsScreenView: View {
    @State private var viewModel: ViewModel
    @State private var isSortOptionsPresented = false
    
    init() {
        _viewModel = State(initialValue: .init(users: (1...10).map { _ in User.makeFakeUser() }))
    }
    var body: some View {
            List {
                ForEach(viewModel.users.indices, id: \.self) { idx in
                    let user = viewModel.users[idx]
                    StatisticsUserListCellView(
                        rowNumber: idx + 1,
                        userName: user.name,
                        rating: user.rating,
                        avatarUrl: user.avatar)
                }
            }
            .listStyle(.plain)
            .listRowSpacing(8)
            .scrollIndicators(.hidden)
            .scrollContentBackground(.hidden)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    SortingToolbarButtonView(viewModel: $viewModel)
                }
            }
            // hack for hiding horizontal tabbar and navigation bar separators
            .padding(.vertical, 1)
            .padding(.horizontal, 16)
    }
}

#Preview {
    StatisticsScreenView()
}
