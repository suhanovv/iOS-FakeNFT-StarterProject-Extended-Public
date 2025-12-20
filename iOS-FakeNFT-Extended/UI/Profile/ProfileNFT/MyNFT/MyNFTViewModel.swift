//
//  MyNFTViewModel.swift
//  iOS-FakeNFT-Extended
//
//  Created by Ди Di on 17/12/25.
//

import SwiftUI

@Observable
@MainActor
final class MyNFTViewModel {
    private let nftService: NftService
    private let nftIds: [String]
    
    var nfts: [Nft] = []
    var isLoading = false
    var isError = false
    
    init(nftService: NftService, nftIds: [String]) {
        self.nftService = nftService
        self.nftIds = nftIds
    }
    
    func load() async {
        isLoading = true
        isError = false
        
        do {
            nfts = try await withThrowingTaskGroup(
                of: Nft.self,
                returning: [Nft].self
            ) { group in
                for id in nftIds {
                    group.addTask {
                        try await self.nftService.loadNft(id: id)
                    }
                }
                
                var result: [Nft] = []
                for try await nft in group {
                    result.append(nft)
                }
                return result
            }
        } catch {
            isError = true
        }
        isLoading = false
    }
    
    func sortedNFTs(
        from nfts: [Nft],
        sortType: NftSortType
    ) -> [Nft] {
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
