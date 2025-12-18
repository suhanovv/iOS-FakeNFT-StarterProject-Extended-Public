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
        private(set) var state: ScreenState?
        private(set) var users: [User] = []
        private let usersService: UsersServiceProtocol
        private var currentPage = 0
        
        init(usersService: UsersServiceProtocol) {
            self.usersService = usersService
        }
        
        func changeOrderBy(_ orderBy: UsersSortType) async {
            do {
                let page = 0
                users = try await loadPage(page, orderBy: orderBy)
                currentPage = page
            } catch {
                state = .error(operation: .changeSortOrder(orderBy))
            }
        }
        
        func loadFirstPage(orderBy: UsersSortType) async {
            if !users.isEmpty { return }
            do {
                users = try await loadPage(currentPage, orderBy: orderBy)
            } catch {
                state = .error(operation: .loadFirstPage(orderBy))
            }
        }
        
        func loadNextPage(orderBy: UsersSortType) async {
            do {
                let page = currentPage + 1
                users.append(contentsOf: try await loadPage(page, orderBy: orderBy))
                currentPage = page
            } catch {
                state = .error(operation: .loadNextPage(orderBy))
            }
        }
        
        func setState(_ state: ScreenState) {
            self.state = state
        }
        
        func retryOperation(_ operation: OperationType) async {
            switch operation {
                case .changeSortOrder(let orderBy):
                    await changeOrderBy(orderBy)
                case .loadFirstPage(let orderBy):
                    await loadFirstPage(orderBy: orderBy)
                case .loadNextPage(let orderBy):
                    await loadNextPage(orderBy: orderBy)
            }
        }
        
        private func loadPage(_ page: Int, orderBy: UsersSortType) async throws -> [User] {
            state = .loading
            let users = try await usersService.getUsers(page: page, orderBy: orderBy)
            state = .loaded
            return users
        }
    }
}
