//
//  FavNFTViewModel.swift
//  iOS-FakeNFT-Extended
//
//  Created by Ди Di on 17/12/25.
//

import SwiftUI

@Observable
@MainActor
final class FavNFTViewModel {
    
    private let nftService: NftService
    private let nftIds: [String]
    
    var nfts: [Nft] = []
    var isLoading = false
    
    init(nftService: NftService, nftIds: [String]) {
        self.nftService = nftService
        self.nftIds = nftIds
    }
    
    func load() async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            var loaded: [Nft] = []
            
            try await withThrowingTaskGroup(of: Nft.self) { group in
                for id in nftIds {
                    group.addTask {
                        try await self.nftService.loadNft(id: id)
                    }
                }
                
                for try await nft in group {
                    loaded.append(nft)
                }
            }
            self.nfts = loaded
        } catch {
        }
    }
    
    func removeFavourite(_ id: String, from data: Data) -> Data {
        var ids = (try? JSONDecoder().decode([String].self, from: data)) ?? []
        ids.removeAll { $0 == id }
        return (try? JSONEncoder().encode(ids)) ?? Data()
    }
}
