//
//  FavouritesManager.swift
//  iOS-FakeNFT-Extended
//
//  Created by Ди Di on 12/12/25.
//

import SwiftUI

struct FavouritesStorage {
    @AppStorage(StorageKeys.favouriteNFTIds)
    
    private static var rawFavouriteIds: Data = Data()
    
    static var favouriteIds: [String] {
        (try? JSONDecoder().decode([String].self, from: rawFavouriteIds)) ?? []
    }
    
    static func isFavourite(_ id: String) -> Bool {
        favouriteIds.contains(id)
    }
    
    static func toggle(_ id: String) {
        var ids = favouriteIds
        if ids.contains(id) {
            ids.removeAll { $0 == id }
        } else {
            ids.append(id)
        }
        save(ids)
    }
    
    static func remove(_ id: String) {
        var ids = favouriteIds
        ids.removeAll { $0 == id }
        save(ids)
    }
    
    private static func save(_ ids: [String]) {
        rawFavouriteIds = (try? JSONEncoder().encode(ids)) ?? Data()
    }
}
