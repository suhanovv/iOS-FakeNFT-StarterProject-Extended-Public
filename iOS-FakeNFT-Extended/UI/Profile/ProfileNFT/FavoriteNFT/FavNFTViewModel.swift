//
//  FavNFTViewModel.swift
//  iOS-FakeNFT-Extended
//
//  Created by Ди Di on 17/12/25.
//

import SwiftUI

@Observable
final class FavNFTViewModel {
    
    func favouriteIds(from data: Data) -> [String] {
        (try? JSONDecoder().decode([String].self, from: data)) ?? []
    }
    
    func favouriteNFTs(
        allNFTs: [NftItem],
        favouriteIds: [String]
    ) -> [NftItem] {
        allNFTs.filter { favouriteIds.contains($0.id) }
    }
    
    func removeFavourite(
        _ id: String,
        from data: Data
    ) -> Data {
        var ids = (try? JSONDecoder().decode([String].self, from: data)) ?? []
        ids.removeAll { $0 == id }
        return (try? JSONEncoder().encode(ids)) ?? Data()
    }
}
