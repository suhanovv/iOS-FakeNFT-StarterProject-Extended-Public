//
//  MyNFTCell.swift
//  iOS-FakeNFT-Extended
//
//  Created by Ди Di on 11/12/25.
//

import SwiftUI
import Kingfisher

struct MyNFTCell: View {
    let nft: NftItem
    let rating: Int
    let isFavourite: Bool
    let onLikeTap: () -> Void
    
    var body: some View {
        HStack(spacing: 20) {
            nftImageSection
            nftDescriptionSection
            Spacer()
            nftPriceSection
        }
    }
    
    private var nftImageSection: some View {
        ZStack(alignment: .topTrailing) {
            nftAsyncImage
                .frame(width: 108, height: 108)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            Button {
                onLikeTap()
            } label: {
                Image(.NftCardIcons.like)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .foregroundColor(isFavourite ? .ypRedUniversal : .ypWhiteUniversal)
            }
            .buttonStyle(.plain)
        }
    }
    
    private var nftAsyncImage: some View {
        NFTImageView(
            imageURL: nft.images?.first,
            placeholder: Image(.emptyNft)
        )
        .frame(width: 108, height: 108)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
    
    private var placeholder: some View {
        Image(.emptyNft)
            .resizable()
            .scaledToFill()
    }
    
    private var nftDescriptionSection: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(nft.name ?? "")
                .font(Font(UIFont.bodyBold))
                .foregroundColor(.ypBlack)
            
            ratingStars
            
            if let author = nft.author {
                Text("от \(author)")
                    .font(Font(UIFont.caption2))
                    .foregroundColor(.ypBlack)
            }
        }
    }
    
    private var ratingStars: some View {
        NFTRatingView(rating: rating)
    }
    
    private var nftPriceSection: some View {
        VStack(alignment: .leading) {
            Text(Constants.price)
                .font(Font(UIFont.caption2))
                .foregroundColor(.ypBlack)
            Text(nft.price ?? 0, format: .currency(code: Constants.currencyCode))
                .font(Font(UIFont.bodyBold))
                .foregroundColor(.ypBlack)
        }
    }
}

private enum Constants {
    static let price = NSLocalizedString("Profile.price", comment: "")
    static let currencyCode = "ETH"
}

#Preview("Favourite") {
    MyNFTCell(
        nft: NftItem(
            id: "1",
            name: "Favourite NFT",
            images: [
                "https://code.s3.yandex.net/Mobile/iOS/NFT/Pink/Lilo/1.png"
            ],
            rating: 5,
            price: 40.59,
            author: "John Doe",
            createdAt: nil,
            description: nil,
            website: nil
        ),
        rating: 5,
        isFavourite: true,
        onLikeTap: {}
    )
    .padding()
}

#Preview("Not Favourite") {
    MyNFTCell(
        nft: NftItem(
            id: "2",
            name: "Not Favourite NFT",
            images: [
                "https://code.s3.yandex.net/Mobile/iOS/NFT/Pink/Lilo/2.png"
            ],
            rating: 3,
            price: 25.00,
            author: "Jane Doe",
            createdAt: nil,
            description: nil,
            website: nil
        ),
        rating: 3,
        isFavourite: false,
        onLikeTap: {}
    )
    .padding()
}
