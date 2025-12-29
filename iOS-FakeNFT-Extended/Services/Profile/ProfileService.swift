import Foundation

protocol ProfileServiceProtocol: Sendable {
    func addLikeForNft(_ nftId: String) async throws -> [String]
    func removeLikeFromNft(_ nftId: String) async throws -> [String]
    func getProfileLikes() async throws -> [String]

    func getProfile() async throws -> Profile
    func updateProfile(_ request: ProfileUpdateRequest) async throws -> Profile
}

actor ProfileService: ProfileServiceProtocol {

    private let networkClient: NetworkClient

    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }

    func getProfile() async throws -> Profile {
        let request = GetProfileRequest()
        return try await networkClient.send(request: request)
    }

    func getProfileLikes() async throws -> [String] {
        let profile = try await getProfile()
        return profile.likes
    }

    func addLikeForNft(_ nftId: String) async throws -> [String] {
        let currentLikes = try await getProfileLikes()
        let newLikes = currentLikes.contains(nftId)
            ? currentLikes
            : currentLikes + [nftId]

        return try await updateLikes(newLikes)
    }

    func removeLikeFromNft(_ nftId: String) async throws -> [String] {
        let currentLikes = try await getProfileLikes()
        let newLikes = currentLikes.filter { $0 != nftId }
        return try await updateLikes(newLikes)
    }

    func updateProfile(_ request: ProfileUpdateRequest) async throws -> Profile {
        let networkRequest = UpdateProfileRequest(dto: request)
        return try await networkClient.send(request: networkRequest)
    }

    private func updateLikes(_ likes: [String]) async throws -> [String] {
        let dto = UpdateLikesDto(likes: likes)
        let request = UpdateLikesRequest(dto: dto)
        let profile: Profile = try await networkClient.send(request: request)
        return profile.likes
    }
}
