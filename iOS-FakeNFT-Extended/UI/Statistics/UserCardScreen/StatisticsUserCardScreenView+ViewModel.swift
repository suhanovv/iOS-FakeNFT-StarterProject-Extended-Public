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
        private(set) var state: ScreenState?
        private(set) var user: User?
        private let userService: UsersServiceProtocol
        
        init(userId: String, usersService: UsersServiceProtocol) {
            self.userId = userId
            self.userService = usersService
        }
        
        func loadUserCard() async {
            if user != nil { return }
            do {
                state = .loading
                user = try await userService.getUserById(userId)
                state = .loaded
            } catch {
                state = .error
            }
        }
        
        func setState(_ state: ScreenState) {
            self.state = state
        }
    }
}
