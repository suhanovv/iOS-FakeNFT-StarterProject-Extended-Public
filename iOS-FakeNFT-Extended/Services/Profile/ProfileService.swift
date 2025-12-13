import Foundation

protocol ProfileServiceProtocol {
    func addLikeForNft(_ nftId: String) async throws
    func removeLikeFromNft(_ nftId: String) async throws
    func getProfileLikes() async throws -> [String]
}

actor ProfileService: ProfileServiceProtocol {
    
    private let networkClient: NetworkClient
    
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    func addLikeForNft(_ nftId: String) async throws {
        let currentLikes: [String] = try await getProfileLikes()
        let newLikes: [String] = currentLikes.contains(nftId) ? currentLikes : currentLikes + [nftId]
        try await makeUpdateRequestAndSend(with: newLikes)
    }

    func removeLikeFromNft(_ nftId: String) async throws {
        let currentLikes: [String] = try await getProfileLikes()
        let newLikes: [String] = currentLikes.filter { $0 != nftId }
        try await makeUpdateRequestAndSend(with: newLikes)
    }
    
    private func makeUpdateRequestAndSend(with likes: [String]) async throws {
        let updateLikesDto = UpdateLikesDto(likes: likes)
        let updateRequest = UpdateLikesRequest(dto: updateLikesDto)
        let _ = try await networkClient.send(request: updateRequest)
    }

    func getProfileLikes() async throws -> [String] {
        let request = GetProfileRequest()
        let profile: Profile = try await networkClient.send(request: request)
        return profile.likes
    }
}
