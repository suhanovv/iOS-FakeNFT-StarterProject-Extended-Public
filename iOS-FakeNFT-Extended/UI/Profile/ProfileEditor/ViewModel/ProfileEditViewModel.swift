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
    var isPhotoMenuPresented = false
    var showLinkPhotoAlert = false
    var photoURLText = ""
    var showExitAlert = false
    
    func photoURL(savedPhotoURL: String) -> URL? {
        URL(string: savedPhotoURL)
    }
    
    func hasChanges(
        storedName: String,
        storedDescription: String,
        storedWebsite: String
    ) -> Bool {
        name != storedName ||
        description != storedDescription ||
        website != storedWebsite
    }
    
    // MARK: - Actions
    func onAppear(
        storedName: String,
        storedDescription: String,
        storedWebsite: String
    ) {
        name = storedName
        description = storedDescription
        website = storedWebsite
    }
    
    func applyPhotoURL(savedPhotoURL: inout String) {
        let trimmed = photoURLText.trimmingCharacters(in: .whitespacesAndNewlines)
        if URL(string: trimmed) != nil {
            savedPhotoURL = trimmed
        }
    }
    
    func saveProfile(
        storedName: inout String,
        storedDescription: inout String,
        storedWebsite: inout String
    ) {
        storedName = name
        storedDescription = description
        storedWebsite = website
    }
}
