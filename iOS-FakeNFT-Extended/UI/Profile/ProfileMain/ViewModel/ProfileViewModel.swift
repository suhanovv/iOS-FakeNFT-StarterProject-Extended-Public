//
//  ProfileViewModel.swift
//  iOS-FakeNFT-Extended
//
//  Created by Ди Di on 16/12/25.
//

import Observation
import Foundation

@Observable
@MainActor
final class ProfileViewModel {
    private let profileService: ProfileServiceProtocol
    
    var profile: User?
    var isLoading = false
    var isError = false
    
    init(profileService: ProfileServiceProtocol) {
        self.profileService = profileService
    }
    
    func loadProfile() async {
        isLoading = true
        isError = false
        do {
            let profileDTO = try await profileService.getProfile()
            
            profile = User(
                name: profileDTO.name,
                avatar: profileDTO.avatar,
                description: profileDTO.description,
                website: profileDTO.website,
                nfts: profileDTO.nfts,
                likes: profileDTO.likes,
                rating: profileDTO.rating,
                id: profileDTO.id
            )
        } catch {
            isError = true
        }
        isLoading = false
    }
    
    var avatarURL: URL? {
        profile?.avatar
    }
    
    var name: String {
        profile?.name ?? ""
    }
    
    var description: String {
        profile?.description ?? ""
    }
    
    var websiteURL: URL? {
        profile?.website
    }
    
    var myNFTCount: Int {
        profile?.nfts.count ?? 0
    }
    
    var favouriteNFTCount: Int {
        profile?.likes.count ?? 0
    }
}
