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
    private let originalProfile: Profile
    
    var name: String
    var description: String
    var website: String
    var photoURLText: String
    
    var isSaving = false
    var isPhotoMenuPresented = false
    var showLinkPhotoAlert = false
    var showExitConfirmation = false

    init(profile: Profile, profileService: ProfileServiceProtocol) {
        self.originalProfile = profile
        self.profileService = profileService

        self.name = profile.name
        self.description = profile.description ?? ""
        self.website = profile.website?.absoluteString ?? ""
        self.photoURLText = profile.avatar?.absoluteString ?? ""
    }
    
    var avatarURL: URL? {
        let trimmed = photoURLText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return nil }
        return URL(string: trimmed)
    }
    
    func hasChanges() -> Bool {
        name != originalProfile.name ||
        description != originalProfile.description ||
        website != (originalProfile.website?.absoluteString ?? "") ||
        (photoURLText != (originalProfile.avatar?.absoluteString ?? ""))
    }
    
    // MARK: - Actions
    func onAppear(profile: Profile) {
        name = profile.name
        description = profile.description ?? ""
        website = profile.website?.absoluteString ?? ""
        photoURLText = profile.avatar?.absoluteString ?? ""
    }
    
    func saveProfile() async throws -> Profile {
        let request = makeUpdateRequest() ?? ProfileUpdateRequest(
            name: nil,
            avatar: photoURLText,
            description: nil,
            website: nil,
            likes: nil
        )

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
            let original = originalProfile.description
            guard description != original else { return nil }
            hasAnyChanges = true
            return description
        }()
        
        let updatedWebsite: String? = {
            let original = originalProfile.website?.absoluteString ?? ""
            guard website != original else { return nil }
            hasAnyChanges = true
            return website
        }()
        
        let updatedAvatar: String? = {
            let original = originalProfile.avatar?.absoluteString ?? ""
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
