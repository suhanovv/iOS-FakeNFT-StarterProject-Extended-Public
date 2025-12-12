import Foundation

enum UsersSortBy: String {
    case name
    case rating
}

protocol UsersServiceProtocol: Sendable {
    func getUsers(page: Int?, orderBy: UsersSortBy) async throws -> [User]
    func getUserById(_ userId: String) async throws -> User
}

actor UsersService: UsersServiceProtocol {
    private let networkClient: NetworkClient
    private let perPage = 20
    
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    func getUsers(page: Int?, orderBy: UsersSortBy) async throws -> [User] {
        let request = GetUsersRequest(page: page ?? 0, size: perPage, sortBy: orderBy.rawValue)
        return try await networkClient.send(request: request)
    }

    func getUserById(_ userId: String) async throws -> User {
        let request = GetUserByIdRequest(userId: userId)
        return try await networkClient.send(request: request)
    }
}
