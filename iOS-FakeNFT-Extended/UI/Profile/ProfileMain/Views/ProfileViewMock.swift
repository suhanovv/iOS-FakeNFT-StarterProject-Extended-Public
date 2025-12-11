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
    
    let mockNFT = NftItem(
        id: "594aaf01-5962-4ab7-a6b5-470ea37beb93",
        name: "Minnie Sanders",
        images: [
            "https://code.s3.yandex.net/Mobile/iOS/NFT/Pink/Lilo/1.png",
            "https://code.s3.yandex.net/Mobile/iOS/NFT/Pink/Lilo/2.png",
            "https://code.s3.yandex.net/Mobile/iOS/NFT/Pink/Lilo/3.png"
        ],
        rating: 2,
        price: 40.59,
        author: "https://wonderful_dubinsky.fakenfts.org/",
        createdAt: "2023-07-11T00:08:48.728Z[GMT]",
        description: "mediocritatem interdum eleifend penatibus adipiscing mattis"
    )
}
