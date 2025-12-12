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
        nftIds: ["1", "2"]
    )
    
    static let redCollection = CollectionDTO(
        id: "3",
        name: "Red",
        cover: URL(string: "https://example.com/cover.png")!,
        description: "Персиковый — как облака над закатным солнцем в океане. В этой коллекции совмещены трогательная нежность и живая игривость сказочных зефирных зверей.",
        authorId: "author-1",
        authorName: "John Doe",
        website: URL(string: "https://practicum.yandex.ru/ios-developer/")!,
        nftIds: ["1", "2", "3"]
    )

    static let collections: [CollectionDTO] = [
        peachCollection, blueCollection, redCollection]

    static let nfts: [Nft] = [
        Nft(
            id: "1",
            images: [URL(string: "https://example.com/archie.png")!],
            name: "Archie",
            rating: 3,
            price: 1
        ),
        Nft(
            id: "2",
            images: [URL(string: "https://example.com/archie.png")!],
            name: "Ruby",
            rating: 3,
            price: 1
        ),
        Nft(
            id: "3",
            images: [URL(string: "https://example.com/archie.png")!],
            name: "Nacho",
            rating: 3,
            price: 1
        ),
        Nft(
            id: "4",
            images: [URL(string: "https://example.com/archie.png")!],
            name: "Ruby",
            rating: 3,
            price: 1
        ),
        Nft(
            id: "5",
            images: [URL(string: "https://example.com/archie.png")!],
            name: "Ruby",
            rating: 3,
            price: 1
        ),
        Nft(
            id: "6",
            images: [URL(string: "https://example.com/archie.png")!],
            name: "Ruby",
            rating: 3,
            price: 1
        )
    ]
}
