//
//  MockCatalogue.swift
//  iOS-FakeNFT-Extended
//
//  Created by Diana Viter on 09.12.2025.
//

import Foundation

enum MockData {
    static let peachCollection = CollectionDTO(
        id: "1",
        name: "Peach",
        cover: URL(string: "https://example.com/cover.png")!,
        description: "Персиковый — как облака над закатным солнцем в океане. В этой коллекции совмещены трогательная нежность и живая игривость сказочных зефирных зверей.",
        authorId: "author-1",
        authorName: "John Doe",
        website: URL(string: "https://practicum.yandex.ru/ios-developer/")!,
        nftIds: ["1", "2", "3", "4", "5", "6"]
    )
    
    static let blueCollection = CollectionDTO(
        id: "2",
        name: "Blue",
        cover: URL(string: "https://example.com/cover.png")!,
        description: "Персиковый — как облака над закатным солнцем в океане. В этой коллекции совмещены трогательная нежность и живая игривость сказочных зефирных зверей.",
        authorId: "author-1",
        authorName: "John Doe",
        website: URL(string: "https://practicum.yandex.ru/ios-developer/")!,
        nftIds: ["1", "2", "3", "4", "5", "6"]
    )

    static let collections: [CollectionDTO] = [
        peachCollection, blueCollection]

    static let nfts: [Nft] = [
        Nft(
            id: "1",
            name: "Archie",
            images: [URL(string: "https://example.com/archie.png")!],
            rating: 3,
            price: 1,
            author: "John Doe",
            website: nil,
            description: "desc",
            createdAt: "2025-01-01"
        ),
        Nft(
            id: "2",
            name: "Ruby",
            images: [URL(string: "https://example.com/ruby.png")!],
            rating: 4,
            price: 1,
            author: "John Doe",
            website: nil,
            description: "desc",
            createdAt: "2025-01-01"
        ),
        Nft(
            id: "3",
            name: "Nacho",
            images: [URL(string: "https://example.com/nacho.png")!],
            rating: 5,
            price: 1,
            author: "John Doe",
            website: nil,
            description: "desc",
            createdAt: "2025-01-01"
        ),
        Nft(
            id: "4",
            name: "Nacho",
            images: [URL(string: "https://example.com/nacho.png")!],
            rating: 5,
            price: 1,
            author: "John Doe",
            website: nil,
            description: "desc",
            createdAt: "2025-01-01"
        ),
        Nft(
            id: "5",
            name: "Nacho",
            images: [URL(string: "https://example.com/nacho.png")!],
            rating: 5,
            price: 1,
            author: "John Doe",
            website: nil,
            description: "desc",
            createdAt: "2025-01-01"
        ),
        Nft(
            id: "6",
            name: "Nacho",
            images: [URL(string: "https://example.com/nacho.png")!],
            rating: 5,
            price: 1,
            author: "John Doe",
            website: nil,
            description: "desc",
            createdAt: "2025-01-01"
        )
    ]
}
