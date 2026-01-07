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
    @Bindable var viewModel: StatisticsUserCardScreenView.ViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            let user = viewModel.user
            StatisticsUserCard(
                avatar: user?.avatar,
                name: user?.name ?? "",
                description: user?.description ?? "")
            if let url = viewModel.user?.website {
                UserWebPageButton(url: url) {
                    coordinator.push(.webView(url:url))
                }.padding(.top, 28)
            }
            UserNftTokensLink(nftCount: viewModel.nftCount).padding(.top, 41).onTapGesture {
                coordinator.push(Screen.userCollection(userId: viewModel.userId))
            }
            Spacer()
        }
        .opacity(viewModel.state == nil || viewModel.user == nil ? 0 : 1)
        .overlay {
            ProgressBarView(isActive: viewModel.state == .loading)
        }
        .alert(
            Constants.errorTitle,
            isPresented: .constant(viewModel.state == .error)
        ) {
            Button(Constants.errorButtonCancelTitle, role: .cancel) {
                viewModel.setState(.loaded)
            }
            Button(Constants.errorButtonRetryTitle) {
                Task {
                    await viewModel.loadUserCard()
                }
            }.keyboardShortcut(.defaultAction)
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
