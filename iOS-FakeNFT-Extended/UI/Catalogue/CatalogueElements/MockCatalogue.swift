//
//  MockCatalogue.swift
//  iOS-FakeNFT-Extended
//
//  Created by Diana Viter on 09.12.2025.
//

import Foundation

enum MockData {

    // MARK: - Helpers

    private static func makeURL(_ string: String) -> URL {
        guard let url = URL(string: string) else {
            assertionFailure("Invalid URL: \(string)")
            return URL(fileURLWithPath: "/")
        }
        return url
    }

    // MARK: - Collections

    static let peachCollection = CollectionDTO(
        id: "1",
        name: "Peach",
        cover: makeURL("https://example.com/cover.png"),
        description: "Персиковый — как облака над закатным солнцем в океане. В этой коллекции совмещены трогательная нежность и живая игривость сказочных зефирных зверей.",
        authorId: "author-1",
        authorName: "John Doe",
        website: makeURL("https://practicum.yandex.ru/ios-developer/"),
        nftIds: ["1", "2", "3", "4", "5", "6"]
    )

    static let blueCollection = CollectionDTO(
        id: "2",
        name: "Blue",
        cover: makeURL("https://example.com/cover.png"),
        description: "Персиковый — как облака над закатным солнцем в океане.",
        authorId: "author-1",
        authorName: "John Doe",
        website: makeURL("https://practicum.yandex.ru/ios-developer/"),
        nftIds: ["1", "2"]
    )

    static let redCollection = CollectionDTO(
        id: "3",
        name: "Red",
        cover: makeURL("https://example.com/cover.png"),
        description: "Персиковый — как облака над закатным солнцем в океане.",
        authorId: "author-1",
        authorName: "John Doe",
        website: makeURL("https://practicum.yandex.ru/ios-developer/"),
        nftIds: ["1", "2", "3"]
    )

    static let collections: [CollectionDTO] = [
        peachCollection,
        blueCollection,
        redCollection
    ]

    // MARK: - NFTs

    static let nfts: [Nft] = [
        Nft(
            id: "1",
            images: [makeURL("https://example.com/archie.png")],
            name: "Archie",
            rating: 3,
            price: 1
        ),
        Nft(
            id: "2",
            images: [makeURL("https://example.com/archie.png")],
            name: "Ruby",
            rating: 3,
            price: 1
        ),
        Nft(
            id: "3",
            images: [makeURL("https://example.com/archie.png")],
            name: "Nacho",
            rating: 3,
            price: 1
        )
    ]
}
