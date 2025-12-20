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
    
    init(profileService: ProfileServiceProtocol) {
        self.profileService = profileService
    }
    
    func photoURL(savedPhotoURL: String) -> URL? {
        URL(string: savedPhotoURL)
    }
    
    //    func loadProfile() async {
    //        do {
    //            profile = try await profileService.loadProfile()
    //        } catch {
    //            // error
    //        }
    //    }
}
