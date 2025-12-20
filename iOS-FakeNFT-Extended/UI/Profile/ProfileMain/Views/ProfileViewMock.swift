//
//  ProfileViewMock.swift
//  iOS-FakeNFT-Extended
//
//  Created by Ди Di on 05/12/25.
//

import SwiftUI

//struct ProfileViewMock {
//    static let preview: some View = {
//        let photoURL = "profile_photo_url"
//        
//        UserDefaults.standard.set(
//            "https://picsum.photos/id/237/200/200",
//            forKey: photoURL
//        )
//        UserDefaults.standard.set(
//            "Michael Phoenix",
//            forKey: "profile_name"
//        )
//        UserDefaults.standard.set(
//            "Дизайнер из Казани, люблю цифровое искусство и бейглы. В моей коллекции уже 100+ NFT, и еще больше — на моём сайте. Открыт к коллаборациям.",
//            forKey: "profile_description"
//        )
//        UserDefaults.standard.set(
//            "eJoaquinPhoenix.com",
//            forKey: "profile_website"
//        )
//        
//        return ProfileView(profileService: ProfileServiceMock())
//    }()
//    
//    static let mockNFT = Nft(
//        id: "594aaf01-5962-4ab7-a6b5-470ea37beb93",
//        name: "Minnie Sanders",
//        images: [
//            "https://code.s3.yandex.net/Mobile/iOS/NFT/Pink/Lilo/1.png",
//            "https://code.s3.yandex.net/Mobile/iOS/NFT/Pink/Lilo/2.png",
//            "https://code.s3.yandex.net/Mobile/iOS/NFT/Pink/Lilo/3.png"
//        ],
//        rating: 2,
//        price: 40.59,
//        author: "https://wonderful_dubinsky.fakenfts.org/",
//        createdAt: "2023-07-11T00:08:48.728Z[GMT]",
//        description: "mediocritatem interdum eleifend penatibus adipiscing mattis"
//    )
//    
//    static let mockNFTs: [Nft] = [
//        NftItem(
//            id: "1",
//            name: "Lilo #1",
//            images: [
//                "https://code.s3.yandex.net/Mobile/iOS/NFT/Pink/Lilo/1.png"
//            ],
//            rating: 2,
//            price: 40.59,
//            author: "Автор 1",
//            createdAt: nil,
//            description: nil
//        ),
//        NftItem(
//            id: "2",
//            name: "Ailo #2",
//            images: [
//                "https://code.s3.yandex.net/Mobile/iOS/NFT/Pink/Lilo/2.png"
//            ],
//            rating: 4,
//            price: 55.00,
//            author: "Автор 2",
//            createdAt: nil,
//            description: nil
//        ),
//        NftItem(
//            id: "3",
//            name: "Filo #3",
//            images: [
//                "https://code.s3.yandex.net/Mobile/iOS/NFT/Pink/Lilo/3.png"
//            ],
//            rating: 5,
//            price: 70.25,
//            author: "Автор 3",
//            createdAt: nil,
//            description: nil
//        )
//    ]
//}
//
//struct ProfileServiceMock: ProfileServiceProtocol {
//
//    func getProfile() async throws -> User {
//        User(
//            name: "Michael Phoenix",
//            avatar: URL(string: "https://picsum.photos/id/237/200/200"),
//            description: "Дизайнер из Казани, люблю цифровое искусство и бейглы. В моей коллекции уже 100+ NFT.",
//            website: URL(string: "https://joaquinphoenix.com")!,
//            nfts: ["1", "2", "3"],
//            likes: ["1", "3"],
//            rating: 5,
//            id: "mock-user-id"
//        )
//    }
//
//    func addLikeForNft(_ nftId: String) async throws -> [String] {
//        // имитируем добавление лайка
//        var likes = ["1", "3"]
//        if !likes.contains(nftId) {
//            likes.append(nftId)
//        }
//        return likes
//    }
//
//    func removeLikeFromNft(_ nftId: String) async throws -> [String] {
//        // имитируем удаление лайка
//        return ["1", "3"].filter { $0 != nftId }
//    }
//
//    func getProfileLikes() async throws -> [String] {
//        ["1", "3"]
//    }
//}
