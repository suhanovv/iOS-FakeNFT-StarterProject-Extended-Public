//
//  MyNFTViewModel.swift
//  iOS-FakeNFT-Extended
//
//  Created by Ди Di on 17/12/25.
//

import SwiftUI

@Observable
final class MyNFTViewModel {
    
    func sortedNFTs(
        from nfts: [NftItem],
        sortType: NftSortType
    ) -> [NftItem] {
        switch sortType {
        case .byPrice:
            return nfts.sorted { ($0.price ?? 0) < ($1.price ?? 0) }
        case .byRating:
            return nfts.sorted { ($0.rating ?? 0) > ($1.rating ?? 0) }
        case .byName:
            return nfts.sorted { ($0.name ?? "") < ($1.name ?? "") }
        }
    }
    
    func favouriteIds(from data: Data) -> Set<String> {
        Set((try? JSONDecoder().decode([String].self, from: data)) ?? [])
    }
}
