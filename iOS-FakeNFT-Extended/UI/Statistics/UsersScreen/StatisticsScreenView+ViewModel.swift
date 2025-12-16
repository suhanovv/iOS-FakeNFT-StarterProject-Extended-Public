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
        private(set) var state: ScreenState = .loaded
        private(set) var users: [User] = []
        private let usersService: UsersServiceProtocol
        private var currentPage = 0
        
        init(usersService: UsersServiceProtocol) {
            self.usersService = usersService
        }
        
        func changeOrderBy(_ orderBy: UsersSortType) async {
            let page = 0
            users = await loadPage(page, orderBy: orderBy)
            currentPage = page
        }
        
        func loadFirstPage(orderBy: UsersSortType) async {
            if !users.isEmpty { return }
            users = await loadPage(currentPage, orderBy: orderBy)
        }
        
        func loadNextPage(orderBy: UsersSortType) async {
            let page = currentPage + 1
            users.append(contentsOf: await loadPage(page, orderBy: orderBy))
            currentPage = page
        }
        
        private func loadPage(_ page: Int, orderBy: UsersSortType) async -> [User] {
            do {
                state = .loading
                let users = try await usersService.getUsers(page: page, orderBy: orderBy)
                state = .loaded
                return users
            } catch {
                state = .error
                return []
            }
        }
    }
}
