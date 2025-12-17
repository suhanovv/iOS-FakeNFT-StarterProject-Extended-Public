//
//  FavNFTCell.swift
//  iOS-FakeNFT-Extended
//
//  Created by Ди Di on 12/12/25.
//

import SwiftUI
import Kingfisher

struct FavNFTCell: View {
    let nft: NftItem
    let rating: Int
    let isFavourite: Bool
    let onLikeTap: () -> Void
    
    var body: some View {
        HStack(spacing: 12) {
            nftImageSection
            nftDescriptionSection
        }
    }
    
    private var nftImageSection: some View {
        ZStack(alignment: .topTrailing) {
            nftAsyncImage
                .frame(width: 80, height: 80)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            Button {
                onLikeTap()
            } label: {
                Image(.NftCardIcons.like)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 42, height: 42)
                    .padding(-5)
                    .foregroundColor(isFavourite ? .ypRedUniversal : .ypWhiteUniversal)
            }
            .buttonStyle(.plain)
        }
    }
    
    private var nftAsyncImage: some View {
        NFTImageView(
            imageURL: nft.images?.first,
            placeholder: Image("EmptyNft")
        )
        .frame(width: 80, height: 80)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
    
    private var placeholder: some View {
        Image("EmptyNft")
            .resizable()
            .scaledToFill()
    }
    
    private var nftDescriptionSection: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(nft.name ?? "")
                .font(Font(UIFont.bodyBold))
                .foregroundColor(.ypBlack)
            ratingStars
            nftPrice
        }
    }
    
    private var ratingStars: some View {
        NFTRatingView(rating: rating)
            .padding(.bottom, 4)
    }
    
    private var nftPrice: some View {
        Text(nft.price ?? 0, format: .currency(code: "ETH"))
            .font(Font(UIFont.caption1))
            .foregroundColor(.ypBlack)
    }
}


// MARK: - Preview_FavNFTCell
#Preview {
    FavNFTCell(
        nft: NftItem(
            id: "1",
            name: "Test NFT",
            images: [
                "https://code.s3.yandex.net/Mobile/iOS/NFT/Pink/Lilo/1.png"
            ],
            rating: 2,
            price: 40.59,
            author: "John Doe",
            createdAt: nil,
            description: "Test description",
            website: nil
        ),
        rating: 2,
        isFavourite: true,
        onLikeTap: {}
    )
    .padding()
}
