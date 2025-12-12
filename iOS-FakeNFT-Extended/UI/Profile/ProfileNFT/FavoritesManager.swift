//
//  FavoritesManager.swift
//  iOS-FakeNFT-Extended
//
//  Created by Ди Di on 12/12/25.
//

import SwiftUI

struct FavoritesStorage {
    private static let key = "favorite_nft_ids"

    @AppStorage(key) private static var rawFavoriteIds: Data = Data()

    static var favoriteIds: [String] {
        (try? JSONDecoder().decode([String].self, from: rawFavoriteIds)) ?? []
    }

    static func isFavorite(_ id: String) -> Bool {
        favoriteIds.contains(id)
    }

    static func toggle(_ id: String) {
        var ids = favoriteIds
        if ids.contains(id) {
            ids.removeAll { $0 == id }
        } else {
            ids.append(id)
        }
        save(ids)
    }

    static func remove(_ id: String) {
        var ids = favoriteIds
        ids.removeAll { $0 == id }
        save(ids)
    }

    private static func save(_ ids: [String]) {
        rawFavoriteIds = (try? JSONEncoder().encode(ids)) ?? Data()
    }
}
