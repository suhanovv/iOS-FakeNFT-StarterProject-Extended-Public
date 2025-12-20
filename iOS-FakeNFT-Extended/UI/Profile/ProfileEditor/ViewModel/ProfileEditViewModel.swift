//
//  ProfileEditViewModel.swift
//  iOS-FakeNFT-Extended
//
//  Created by Ди Di on 16/12/25.
//

import Observation
import Foundation

@Observable
final class ProfileEditViewModel {
    var name: String = ""
    var description: String = ""
    var website: String = ""
    var photoURLText = ""
    
    var isSaving = false
    var isPhotoMenuPresented = false
    var showLinkPhotoAlert = false
    var showExitAlert = false
    
    var avatarURL: URL? {
        if let url = URL(string: photoURLText), !photoURLText.isEmpty {
            return url
        }
        return nil
    }
    
    func hasChanges(comparedTo profile: User) -> Bool {
        name != profile.name ||
        description != (profile.description ?? "") ||
        website != profile.website.absoluteString ||
        photoURLText != profile.avatar?.absoluteString
    }
    
    // MARK: - Actions
    func onAppear(profile: User) {
        name = profile.name
        description = profile.description ?? ""
        website = profile.website.absoluteString
        photoURLText = profile.avatar?.absoluteString ?? ""
    }
    
    func saveProfile() async throws {
        isSaving = true
        defer { isSaving = false }
        
        // TODO: здесь будет PUT /profile
        try await Task.sleep(nanoseconds: 500_000_000)
    }
}
