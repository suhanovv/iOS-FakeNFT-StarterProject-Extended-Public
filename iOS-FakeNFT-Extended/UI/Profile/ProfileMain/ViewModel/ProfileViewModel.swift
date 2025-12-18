//
//  ProfileViewModel.swift
//  iOS-FakeNFT-Extended
//
//  Created by Ди Di on 16/12/25.
//

import Observation
import Foundation

@Observable
final class ProfileViewModel {
    var isEditing = false
    
    func photoURL(savedPhotoURL: String) -> URL? {
        URL(string: savedPhotoURL)
    }
}
