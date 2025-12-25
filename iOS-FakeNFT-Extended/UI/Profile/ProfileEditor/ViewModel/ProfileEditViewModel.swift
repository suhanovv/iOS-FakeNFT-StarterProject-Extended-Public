//
//  ProfileEditViewModel.swift
//  iOS-FakeNFT-Extended
//
//  Created by Ди Di on 16/12/25.
//

import Observation
import Foundation

@Observable
@MainActor
final class ProfileEditViewModel {
    private let profileService: ProfileServiceProtocol
    private let originalProfile: User
    
    var name: String
    var description: String
    var website: String
    var photoURLText: String
    
    var isSaving = false
    var isPhotoMenuPresented = false
    var showLinkPhotoAlert = false
    var showExitAlert = false
    
    init(profile: User, profileService: ProfileServiceProtocol) {
        self.originalProfile = profile
        self.profileService = profileService
        
        self.name = profile.name
        self.description = profile.description ?? ""
        self.website = profile.website
        self.photoURLText = profile.avatarRaw ?? ""
    }
    
    var avatarURL: URL? {
        let trimmed = photoURLText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return nil }
        return URL(string: trimmed)
    }
    
    func hasChanges(comparedTo profile: User) -> Bool {
        name != profile.name ||
        description != (profile.description ?? "") ||
        website != (profile.website) ||
        photoURLText != (profile.avatarRaw ?? "")
        
    }
    
    // MARK: - Actions
    func onAppear(profile: User) {
        name = profile.name
        description = profile.description ?? ""
        website = profile.website
        photoURLText = profile.avatarRaw ?? ""
        
    }
    
    func saveProfile() async throws -> User {
        guard let request = makeUpdateRequest() else {
            return originalProfile
        }
        
        isSaving = true
        defer { isSaving = false }
        
        return try await profileService.updateProfile(request)
    }
    
    func makeUpdateRequest() -> ProfileUpdateRequest? {
        var hasAnyChanges = false
        
        let updatedName: String? = {
            guard name != originalProfile.name else { return nil }
            hasAnyChanges = true
            return name
        }()
        
        let updatedDescription: String? = {
            let original = originalProfile.description ?? ""
            guard description != original else { return nil }
            hasAnyChanges = true
            return description
        }()
        
        let updatedWebsite: String? = {
            let original = originalProfile.website
            guard website != original else { return nil }
            hasAnyChanges = true
            return website
        }()
        
        let updatedAvatar: String? = {
            let original = originalProfile.avatarRaw ?? ""
            guard photoURLText != original else { return nil }
            hasAnyChanges = true
            return photoURLText
        }()
        
        guard hasAnyChanges else { return nil }
        
        return ProfileUpdateRequest(
            name: updatedName,
            avatar: updatedAvatar,
            description: updatedDescription,
            website: updatedWebsite,
            likes: nil
        )
    }
}
