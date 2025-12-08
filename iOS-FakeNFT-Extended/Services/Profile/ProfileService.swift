import Foundation

protocol ProfileServiceProtocol {
    func addLikeForUserId(_ userId: Int, nftId: String) async throws
    func removeLikeForUserId(_ userId: Int, nftId: String) async throws
    func getProfileByUserId(_ userId: Int) async throws -> Profile
}
