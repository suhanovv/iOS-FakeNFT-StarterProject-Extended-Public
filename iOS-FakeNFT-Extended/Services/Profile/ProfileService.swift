import Foundation

protocol ProfileServiceProtocol: Sendable {
    func addLikeForNft(_ nftId: String) async throws -> [String]
    func removeLikeFromNft(_ nftId: String) async throws -> [String]
    func getProfileLikes() async throws -> [String]
    func loadProfile() async throws -> Profile
    
}

actor ProfileService: ProfileServiceProtocol {
    
    private var likes: [String] = []
    
    func loadProfile() async throws -> Profile {
        return Profile(
            name: "Local User",
            avatar: nil,
            description: "Offline profile",
            website: URL(string: "https://example.com") ?? URL(fileURLWithPath: ""),
            nfts: [],
            likes: likes,
            id: "local"
        )
    }
    
    func addLikeForNft(_ nftId: String) async throws -> [String] {
        if !likes.contains(nftId) {
            likes.append(nftId)
        }
        return likes
    }
    
    func removeLikeFromNft(_ nftId: String) async throws -> [String] {
        likes.removeAll { $0 == nftId }
        return likes
    }
    
    func getProfileLikes() async throws -> [String] {
        likes
    }
}
//actor ProfileService: ProfileServiceProtocol {
//
//    private let networkClient: NetworkClient
//
//    init(networkClient: NetworkClient) {
//        self.networkClient = networkClient
//    }
//
//    func addLikeForNft(_ nftId: String) async throws -> [String] {
//        let currentLikes: [String] = try await getProfileLikes()
//        let newLikes: [String] = currentLikes.contains(nftId) ? currentLikes : currentLikes + [nftId]
//        return try await makeUpdateRequestAndSend(with: newLikes)
//    }
//
//    func removeLikeFromNft(_ nftId: String) async throws -> [String] {
//        let currentLikes: [String] = try await getProfileLikes()
//        let newLikes: [String] = currentLikes.filter { $0 != nftId }
//        return try await makeUpdateRequestAndSend(with: newLikes)
//    }
//
//    private func makeUpdateRequestAndSend(with likes: [String]) async throws -> [String] {
//        let updateLikesDto = UpdateLikesDto(likes: likes)
//        let updateRequest = UpdateLikesRequest(dto: updateLikesDto)
//        let profile: Profile = try await networkClient.send(request: updateRequest)
//        return profile.likes
//    }
//
//    func getProfileLikes() async throws -> [String] {
//        let request = GetProfileRequest()
//        let profile: Profile = try await networkClient.send(request: request)
//        return profile.likes
//    }
//
//    func loadProfile() async throws -> Profile {
//        let request = GetProfileRequest()
//        return try await networkClient.send(request: request)
//    }
//}
