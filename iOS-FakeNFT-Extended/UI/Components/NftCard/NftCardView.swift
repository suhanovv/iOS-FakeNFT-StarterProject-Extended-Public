//
//  NftCardView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Вадим Суханов on 05.12.2025.
//

import SwiftUI
import Kingfisher

struct NftCardView: View {
    static let width: CGFloat = 108
    let nft: Nft
    let isLiked: Bool
    let isInCart: Bool
    var likeTapAction: () -> Void
    var buyTapAction: () -> Void
    var body: some View {
        VStack(alignment: .leading ,spacing: 8) {
            KFImage(nft.images.first)
                .placeholder {
                    Rectangle()
                        .foregroundStyle(.ypLightGray)
                        .overlay {
                            ProgressView()
                        }
                }
                .resizable()
                .scaledToFit()
                .frame(height: 108)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            VStack(alignment: .leading) {
                RatingView(rating: nft.rating ?? 0)
                HStack {
                    VStack {
                        Text(nft.name ?? "")
                            .font(.system(size: 17, weight: .bold))
                        Text(nft.price ?? 0, format: .currency(code: "ETH"))
                            .font(.system(size: 10, weight: .medium))
                    }
                    
                    Image(isInCart ? .NftCardIcons.cartDelete : .NftCardIcons.cartAdd)
                        .frame(width: 40, height: 40)
                        .onTapGesture {
                            buyTapAction()
                        }
                }
            }
        }
        .overlay(alignment: .topTrailing) {
            Image(.NftCardIcons.like)
                .foregroundStyle(isLiked ? .ypRedUniversal : .ypWhiteUniversal)
                .frame(width: 40, height: 40)
                .onTapGesture {
                    likeTapAction()
                }
        }
        .frame(width: NftCardView.width, height: 192)
    }
}
