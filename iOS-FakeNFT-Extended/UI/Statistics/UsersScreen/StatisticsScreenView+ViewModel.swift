//
//  ViewModel.swift
//  iOS-FakeNFT-Extended
//
//  Created by Вадим Суханов on 09.12.2025.
//
import Observation

extension StatisticsScreenView {
    @Observable
    @MainActor
    final class ViewModel {
        var users: [User]
        private(set) var sortType: UsersSortBy = .rating
        
        init(users: [User]) {
            self.users = users
        }
        
        func setSortType(_ sortType: UsersSortBy) {
            self.sortType = sortType
        }
    }
}
