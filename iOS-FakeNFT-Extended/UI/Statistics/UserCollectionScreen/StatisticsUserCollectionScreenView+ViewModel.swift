//
//  ViewModel.swift
//  iOS-FakeNFT-Extended
//
//  Created by Вадим Суханов on 10.12.2025.
//

import Observation

extension StatisticsUserCollectionScreenView {
    @Observable
    @MainActor
    final class ViewModel {
        let userId: String
        var isEmpty: Bool = false
        var isCollectionEmpty: Bool {
            collection.isEmpty && state == .loaded
        }
        private(set) var state: ScreenState = .loaded
        private(set) var collection: [Nft] = []
        private(set) var likes: Set<String> = []
        private(set) var cart: Set<String> = []
        private let profileService: ProfileServiceProtocol
        private let orderService: OrderServiceProtocol
        private let usersService: UsersServiceProtocol
        private let nftService: NftService
        
        init(
            userId: String,
            profileService: ProfileServiceProtocol,
            orderService: OrderServiceProtocol,
            usersService: UsersServiceProtocol,
            nftService: NftService
        ) {
            self.userId = userId
            self.profileService = profileService
            self.orderService = orderService
            self.usersService = usersService
            self.nftService = nftService
        }
        
        func isLiked(nftId: String) -> Bool {
            likes.contains(nftId)
        }
        
        func isInCart(nftId: String) -> Bool {
            cart.contains(nftId)
        }
        
        func toggleLike(nftId: String) async {
            do {
                state = .loading
                if isLiked(nftId: nftId) {
                    likes = Set(try await profileService.removeLikeFromNft(nftId))
                } else {
                    likes = Set(try await profileService.addLikeForNft(nftId))
                }
                state = .loaded
            } catch {
                state = .error
            }
        }
        
        func toggleInCart(nftId: String) async {
            do {
                state = .loading
                if isInCart(nftId: nftId) {
                    cart = Set(try await orderService.removeFromCartNft(nftId).nfts)
                } else {
                    cart = Set(try await orderService.addToCartNft(nftId).nfts)
                }
                state = .loaded
            } catch {
                state = .error
            }
        }
        
        func loadData() async {
            if !collection.isEmpty { return }
            state = .loading
            do {
                likes = Set(try await loadLikes())
                cart = Set(try await loadCart())
                
                collection = try await loadUserCollection()
                state = .loaded
            } catch {
                state = .error
            }
        }
        
        private func loadUserCollection() async throws -> [Nft] {
            try await withThrowingTaskGroup(of: Nft.self, returning: [Nft].self) { group in
                let collectionIds = try await usersService.getUserById(userId).nfts
                
                for nftId in collectionIds {
                    group.addTask { try await self.nftService.loadNft(id: nftId) }
                }
                
                var nfts: [Nft] = []
                for try await nft in group {
                    nfts.append(nft)
                }
                return nfts
            }
        }
        
        private func loadLikes() async throws -> [String] {
            try await profileService.getProfileLikes()
        }
        
        private func loadCart() async throws -> [String] {
            let order = try await orderService.getOrder()
            return order.nfts
        }
    }
}
