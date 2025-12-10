//
//  ProfileViewMock.swift
//  iOS-FakeNFT-Extended
//
//  Created by Ди Di on 05/12/25.
//

import SwiftUI

struct ProfileViewMock {
    static let preview: some View = {
        UserDefaults.standard.set(
            "https://picsum.photos/id/237/200/200",
            forKey: ProfileStorageKeys.photoURL
        )
        UserDefaults.standard.set(
            "Michael Phoenix",
            forKey: "profile_name"
        )
        UserDefaults.standard.set(
            "Дизайнер из Казани, люблю цифровое искусство и бейглы. В моей коллекции уже 100+ NFT...",
            forKey: "profile_description"
        )
        UserDefaults.standard.set(
            "eJoaquinPhoenix.com",
            forKey: "profile_website"
        )
        
        return ProfileView()
    }()
}
