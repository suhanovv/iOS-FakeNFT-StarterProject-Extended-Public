//
//  ViewModel.swift
//  iOS-FakeNFT-Extended
//
//  Created by Вадим Суханов on 05.12.2025.
//

import Observation
import Foundation

extension NftCardView {
    @Observable
    final class ViewModel {
        let nft: Nft
        var image: URL? {
            nft.images.first
        }
        private(set) var isLiked: Bool
        private(set) var isInCart: Bool
        
        init(nft: Nft, isLiked: Bool, isInCart: Bool) {
            self.nft = nft
            self.isLiked = isLiked
            self.isInCart = isInCart
        }
        
        func likeTapped() {
            isLiked.toggle()
        }
        
        func cartTapped() {
            isInCart.toggle()
        }
    }
}
