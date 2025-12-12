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
        let userId: String
        var nftCount: Int { user?.nfts.count ?? 0 }
        
        private(set) var user: User?
        
        init(userId: String) {
            self.userId = userId
        }
        
        func load() async {
            user = User.makeFakeUser()
        }
    }
}
