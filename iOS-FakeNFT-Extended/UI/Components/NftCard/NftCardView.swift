//
//  NftCardView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Вадим Суханов on 05.12.2025.
//

import SwiftUI
import Kingfisher

struct NftCardView: View {
    @State var viewModel: ViewModel
    static let width: CGFloat = 108
    var body: some View {
        VStack(alignment: .leading ,spacing: 8) {
            KFImage(viewModel.image)
                .placeholder {
                    Rectangle()
                        .foregroundStyle(.ypLightGray)
                        .overlay {
                            ProgressView()
                        }
                }
                .resizable()
                .scaledToFit()
                .frame(width: 108, height: 108)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            VStack(alignment: .leading) {
                RatingView(rating: viewModel.nft.rating)
                HStack {
                    VStack {
                        Text(viewModel.nft.name)
                            .font(.system(size: 17, weight: .bold))
                        Text(viewModel.nft.price, format: .currency(code: "ETH"))
                            .font(.system(size: 10, weight: .medium))
                    }
                    Image(viewModel.isInCart ? .NftCardIcons.cartDelete : .NftCardIcons.cartAdd)
                        .frame(width: 40, height: 40)
                        .onTapGesture {
                            viewModel.cartTapped()
                        }
                }
            }
        }
        .overlay(alignment: .topTrailing) {
            Image(.NftCardIcons.like)
                .foregroundStyle(viewModel.isLiked ? .ypRedUniversal : .ypWhiteUniversal)
                .frame(width: 40, height: 40)
                .onTapGesture {
                    viewModel.likeTapped()
                }
        }
        .frame(width: NftCardView.width, height: 192)
    }
}

#Preview {
    NftCardView(viewModel: NftCardView.ViewModel(nft: Nft.sampleCarmine, isLiked: false, isInCart: false))
    NftCardView(viewModel: NftCardView.ViewModel(nft: Nft.sampleDominique, isLiked: true, isInCart: true))
}
