//
//  StatisticsUserCardScreenView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Вадим Суханов on 09.12.2025.
//

import SwiftUI
import Kingfisher

struct StatisticsUserCardScreenView: View {
    @Environment(Coordinator.self) private var coordinator
    @State private var viewModel: ViewModel
    
    init(userId: String) {
        _viewModel = State(initialValue: StatisticsUserCardScreenView.ViewModel(userId: userId))
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            let user = viewModel.user
            StatisticsUserCard(
                avatar: user?.avatar,
                name: user?.name ?? "",
                description: user?.description ?? "")
            UserWebPageButton().padding(.top, 28)
            UserNftTokensLink(nftCount: viewModel.nftCount).padding(.top, 41).onTapGesture {
                coordinator.push(Screen.userCollection(userId: viewModel.userId))
            }
            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.top, 20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.ypWhite)
        .task {
            await viewModel.load()
        }
    }
}

#Preview {
    StatisticsUserCardScreenView(
        userId: "f62b7dcb-ff81-49e7-954e-358bf6166737"
    ).environment(Coordinator())
}
