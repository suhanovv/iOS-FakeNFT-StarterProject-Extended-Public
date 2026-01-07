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
        private(set) var state: ScreenState?
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
                state = .error(operation: .toggleLike(nftId))
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
                state = .error(operation: .toggleCart(nftId))
            }
        }
        
        func loadData() async {
            state = .loading
            do {
                likes = Set(try await profileService.getProfileLikes())
                cart = Set(try await orderService.getOrder().nfts)
                
                collection = try await loadUserCollection().sorted { $0.id < $1.id}
                state = .loaded
            } catch {
                state = .error(operation: .loadData)
            }
        }
        
        func setState(_ state: ScreenState) {
            self.state = state
        }
        
        func retryOperation(_ operation: OperationType) async {
            switch operation {
                case .loadData:
                    await loadData()
                case .toggleLike(let nftId):
                    await toggleLike(nftId: nftId)
                case .toggleCart(let nftId):
                    await toggleInCart(nftId: nftId)
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
    }
}
