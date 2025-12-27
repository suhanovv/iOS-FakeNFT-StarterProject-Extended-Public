//
//  MyNFTCell.swift
//  iOS-FakeNFT-Extended
//
//  Created by Ди Di on 11/12/25.
//

import SwiftUI
import Kingfisher

struct MyNFTCell: View {
    let nft: Nft
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
            NFTImageView(
                imageURL: nft.images.first?.absoluteString,
                placeholder: Image(.emptyNft)
            )
            .frame(width: 108, height: 108)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            
            Image(.NftCardIcons.like)
                .foregroundStyle(isFavourite ? .ypRedUniversal : .ypWhiteUniversal)
                .frame(width: 40, height: 40)
                .onTapGesture { onLikeTap() }
        }
    }
    
    private var nftAsyncImage: some View {
        NFTImageView(
            imageURL: nft.images.first?.absoluteString,
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
            Text(nft.name)
                .font(.system(size: 17, weight: .bold))
                .foregroundColor(.ypBlack)
                .lineLimit(2)
            
            ratingStars
            
            Text("от \(nft.author)")
                .font(.system(size: 13, weight: .regular))
                .foregroundColor(.ypBlack)
                .lineLimit(2)
        }
    }
    
    private var ratingStars: some View {
        NFTRatingView(rating: rating)
    }
    
    private var nftPriceSection: some View {
        VStack(alignment: .leading) {
            Text(Constants.price)
                .font(.system(size: 13, weight: .regular))
                .foregroundColor(.ypBlack)
            Text(nft.price, format: .currency(code: Constants.currencyCode))
                .font(.system(size: 17, weight: .bold))
                .foregroundColor(.ypBlack)
                .lineLimit(1)
                .fixedSize()
        }
    }
}

private enum Constants {
    static let price = NSLocalizedString("Profile.price", comment: "")
    static let currencyCode = "ETH"
}

// MARK: - Preview_MyNFTCell
#Preview("Favourite") {
    MyNFTCell(
        nft: Nft(
            id: "1",
            images: [
                URL(string: "https://code.s3.yandex.net/Mobile/iOS/NFT/Pink/Lilo/1.png")!
            ],
            rating: 5,
            price: 40.59,
            name: "Favourite NFT",
            author: "John Doe",
            createdAt: "2024-01-01T12:00:00Z",
            description: "Favourite NFT description"
        ),
        rating: 5,
        isFavourite: true,
        onLikeTap: {}
    )
    .padding()
}

#Preview("Not Favourite") {
    MyNFTCell(
        nft: Nft(
            id: "2",
            images: [
                URL(string: "https://code.s3.yandex.net/Mobile/iOS/NFT/Pink/Lilo/2.png")!
            ],
            rating: 3,
            price: 25.0,
            name: "Not Favourite NFT",
            author: "Jane Doe",
            createdAt: "2024-01-02T10:30:00Z",
            description: "Not favourite NFT description"
        ),
        rating: 3,
        isFavourite: false,
        onLikeTap: {}
    )
    .padding()
}
