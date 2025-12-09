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

        return ProfileView(
            name: "Michael Phoenix",
            description: "Дизайнер из Казани, люблю цифровое искусство и бейглы. В моей коллекции уже 100+ NFT, и еще больше — на моём сайте. Открыт к коллаборациям.",
            website: "eJoaquinPhoenix.com"
        )
    }()
}
