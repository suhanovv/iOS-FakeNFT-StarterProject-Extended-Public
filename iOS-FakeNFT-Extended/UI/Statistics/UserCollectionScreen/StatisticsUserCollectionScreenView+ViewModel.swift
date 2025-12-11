//
//  ViewModel.swift
//  iOS-FakeNFT-Extended
//
//  Created by Вадим Суханов on 10.12.2025.
//

import Observation

extension StatisticsUserCollectionScreenView {
    @Observable
    final class ViewModel {
        let userId: String
        var isEmpty: Bool = false
        var isCollectionEmpty: Bool {
            collection.isEmpty && state == .loaded
        }
        private(set) var state: ScreenState = .initial
        private(set) var collection: [Nft] = []
        private(set) var profileLikes: Set<String> = []
        private(set) var cart: Set<String> = []
        
        init(userId: String, isEmpty:Bool = false) {
            self.userId = userId
            self.isEmpty = isEmpty
        }
        
        func isLiked(nftId: String) -> Bool {
            profileLikes.contains(nftId)
        }
        
        func isInCart(nftId: String) -> Bool {
            cart.contains(nftId)
        }
        
        func loadUserCollection() async {
            collection = (1...30).map { _ in Nft.makeRandom() }
        }
        
        func loadLikes() async {
            profileLikes = Set((1...5).map { _ in collection.randomElement()!.id })
        }
        
        func loadCart() async {
            cart = Set((1...3).map { _ in collection.randomElement()!.id })
        }
        
        func loadData() async {
            state = .loading
            defer { state = .loaded }
            try? await Task.sleep(nanoseconds: 1_000_000_000)
            if isEmpty { return }
            await loadUserCollection()
            await loadLikes()
            await loadCart()
        }
    }
}
