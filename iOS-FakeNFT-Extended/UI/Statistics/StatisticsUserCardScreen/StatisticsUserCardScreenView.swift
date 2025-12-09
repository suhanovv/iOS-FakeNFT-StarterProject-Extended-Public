//
//  StatisticsUserCardScreenView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Вадим Суханов on 09.12.2025.
//

import SwiftUI
import Kingfisher

struct StatisticsUserCardScreenView: View {
    @State private var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        _viewModel = State(initialValue: viewModel)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            let user = viewModel.user
            StatisticsUserCard(
                avatar: user?.avatar,
                name: user?.name ?? "",
                description: user?.description ?? "")
            UserWebPageButton().padding(.top, 28)
            UserNftTokensButton(nftCount: viewModel.nftCount).padding(.top, 41)
            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.top, 20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .task {
            await viewModel.load()
        }
    }
}

#Preview {
    StatisticsUserCardScreenView(
        viewModel: StatisticsUserCardScreenView.ViewModel(userId: "f62b7dcb-ff81-49e7-954e-358bf6166737")
    )
}
