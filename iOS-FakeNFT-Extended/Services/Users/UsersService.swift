import Foundation

enum UsersSortBy: String {
    case name
    case rating
}

protocol UsersServiceProtocol {
    func getUsers(page: Int?, orderBy: UsersSortBy?) async throws -> [User]
    func getUserById(_ userId: String) async throws -> User
}
