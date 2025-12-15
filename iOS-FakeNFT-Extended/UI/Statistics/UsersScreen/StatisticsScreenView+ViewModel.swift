//
//  ViewModel.swift
//  iOS-FakeNFT-Extended
//
//  Created by Вадим Суханов on 09.12.2025.
//
import Observation
import Foundation

extension StatisticsScreenView {
    @Observable
    @MainActor
    final class ViewModel {
        private(set) var state: ScreenState = .initial
        private(set) var users: [User] = []
        
        init() {}
        
        func changeOrderBy(_ orderBy: UsersSortType) async {
            await loadData(orderBy: orderBy)
        }
        
        func loadUsers(orderBy: UsersSortType) async {
            if state != .initial { return }
            await loadData(orderBy: orderBy)
        }
        
        private func loadData(orderBy: UsersSortType) async {
            print(orderBy)
            state = .loading
            defer { state = .loaded }
            try? await Task.sleep(nanoseconds: 1_000_000_000)
            users = (1...10)
                .map { _ in User.makeFakeUser() }
                .sorted(by: {(lhs: User, rhs: User) -> Bool in
                    switch orderBy {
                        case .rating:
                            return lhs.rating > rhs.rating
                        case .name:
                            return lhs.name < rhs.name
                    }
                })
        }
    }
}
