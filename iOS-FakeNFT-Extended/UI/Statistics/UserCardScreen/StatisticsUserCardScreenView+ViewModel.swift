//
//  ViewModel.swift
//  iOS-FakeNFT-Extended
//
//  Created by Вадим Суханов on 09.12.2025.
//
import Observation

extension StatisticsUserCardScreenView {
    @Observable
    @MainActor
    final class ViewModel {
        var nftCount: Int { user?.nfts.count ?? 0 }
        private(set) var state: ScreenState = .initial
        private(set) var user: User?
        
        init() {}
        
        func loadUser(_ userId: String) async {
            if state != .initial { return }
            state = .loading
            defer { state = .loaded }
            try? await Task.sleep(nanoseconds: 1_000_000_000)
            user = User.makeFakeUser()
        }
    }
}
