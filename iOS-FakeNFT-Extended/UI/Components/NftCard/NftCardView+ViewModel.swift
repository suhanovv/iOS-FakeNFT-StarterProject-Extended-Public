//
//  ViewModel.swift
//  iOS-FakeNFT-Extended
//
//  Created by Вадим Суханов on 05.12.2025.
//

import SwiftUI

extension NftCardView {
    @Observable
    final class ViewModel {
        let nft: Nft
        var image: URL {
            nft.images[0]
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
