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
    private let profileService: ProfileServiceProtocol
    private(set) var nfts: [Nft] = []
    private(set) var isLikeUpdating = false
    private(set) var likedIds: Set<String> = []
    var state: NFTScreenState = .loading
    
    init(
        nftService: NftService,
        profileService: ProfileServiceProtocol,
        nftIds: [String]
    ) {
        self.nftService = nftService
        self.profileService = profileService
        self.nftIds = nftIds
    }
    
    func toggleLike(nftId: String) async {
        do {
            isLikeUpdating = true
            defer { isLikeUpdating = false }
            
            let updatedLikes: [String]
            if likedIds.contains(nftId) {
                updatedLikes = try await profileService.removeLikeFromNft(nftId)
            } else {
                updatedLikes = try await profileService.addLikeForNft(nftId)
            }
            likedIds = Set(updatedLikes)
        } catch {
            state = .error(operation: .toggleLike(nftId))
        }
    }
    
    func loadData() async {
        state = .loading
        do {
            let likes = try await profileService.getProfileLikes()
            
            let loadedNfts = try await withThrowingTaskGroup(
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
            likedIds = Set(likes)
            nfts = loadedNfts
            state = loadedNfts.isEmpty ? .empty : .loaded
        } catch {
            state = .error(operation: .loadData)
        }
    }
    
    func retry(_ operation: NFTScreenOperation) async {
        switch operation {
        case .loadData:
            await loadData()
            
        case .toggleLike(let nftId):
            await toggleLike(nftId: nftId)
        }
    }
    
    func sortedNFTs(from nfts: [Nft], sortType: NftSortType) -> [Nft] {
        switch sortType {
        case .byPrice:
            return nfts.sorted { ($0.price ?? 0) < ($1.price ?? 0) }
        case .byRating:
            return nfts.sorted { ($0.rating ?? 0) > ($1.rating ?? 0) }
        case .byName:
            return nfts.sorted { ($0.name ?? "") < ($1.name ?? "") }
        }
    }
}
