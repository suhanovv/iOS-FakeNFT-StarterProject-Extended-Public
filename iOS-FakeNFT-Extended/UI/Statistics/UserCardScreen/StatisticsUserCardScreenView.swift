//
//  StatisticsUserCardScreenView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Вадим Суханов on 09.12.2025.
//

import SwiftUI
import Kingfisher

struct StatisticsUserCardScreenView: View {
    enum ScreenState {
        case loading
        case loaded
        case error
    }
    
    @Environment(Coordinator.self) private var coordinator
    @Bindable var viewModel: StatisticsUserCardScreenView.ViewModel

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
        .overlay {
            ProgressBarView(isActive: viewModel.state == .loading)
        }
        .padding(.horizontal, 16)
        .padding(.top, 20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.ypWhite)
        .task {
            await viewModel.loadUserCard()
        }
    }
}
