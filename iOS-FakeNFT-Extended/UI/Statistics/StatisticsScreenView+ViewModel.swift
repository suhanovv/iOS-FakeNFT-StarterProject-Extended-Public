//
//  ViewModel.swift
//  iOS-FakeNFT-Extended
//
//  Created by Вадим Суханов on 09.12.2025.
//
import SwiftUI

extension StatisticsScreenView {
    @Observable
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
