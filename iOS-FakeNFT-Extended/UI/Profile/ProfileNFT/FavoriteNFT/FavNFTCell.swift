//
//  FavNFTCell.swift
//  iOS-FakeNFT-Extended
//
//  Created by Ди Di on 12/12/25.
//

import SwiftUI

struct FavNFTCell: View {
    let nft: NftItem
    let rating: Int
    
    @AppStorage("favorite_nft_ids") private var favoritesMarker: Data = Data()
    
    private var favoriteIds: [String] {
        (try? JSONDecoder().decode([String].self, from: favoritesMarker)) ?? []
    }
    
    private var isFavorite: Bool {
        favoriteIds.contains(nft.id)
    }
    
    private var placeholder: some View {
        Image("EmptyNft")
            .resizable()
            .scaledToFill()
    }
    
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
                FavoritesStorage.remove(nft.id)
            } label: {
                Image(.NftCardIcons.like)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 42, height: 42)
                    .padding(-5)
                    .foregroundColor(isFavorite ? .ypRedUniversal : .ypWhiteUniversal)
            }
            .buttonStyle(.plain)
        }
    }
    
    private var nftAsyncImage: some View {
        return Group {
            if let urlString = nft.images?.first,
               let url = URL(string: urlString) {
                
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        ZStack {
                            placeholder.opacity(0.3)
                            ProgressView()
                                .tint(.ypBlack)
                                .scaleEffect(1.5)
                        }
                        
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                        
                    case .failure:
                        placeholder
                        
                    @unknown default:
                        placeholder
                    }
                }
            } else {
                placeholder
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 12))
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
        HStack(spacing: 2) {
            ForEach(0..<5) { index in
                Image(systemName: "star.fill")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(index < rating ? .ypYellowUniversal : .ypLightGray)
                    .frame(width: 12, height: 12)
                    .padding(.bottom, 4)
            }
        }
    }
    
    private var nftPrice: some View {
        Text(String(format: "%.2f ETH", nft.price ?? 0))
            .font(Font(UIFont.caption1))
            .foregroundColor(.ypBlack)
    }
    
    private func removeFavorite() {
        var ids = favoriteIds
        ids.removeAll { $0 == nft.id }
        favoritesMarker = (try? JSONEncoder().encode(ids)) ?? Data()
    }
}

// MARK: - Preview_FavNFTCell
#Preview {
    NavigationStack {
        FavNFTCell(
            nft: NftItem(
                id: "1",
                name: "Test NFT",
                images: [
                    "https://code.s3.yandex.net/Mobile/iOS/NFT/Pink/Lilo/1.png",
                    "https://code.s3.yandex.net/Mobile/iOS/NFT/Pink/Lilo/2.png",
                    "https://code.s3.yandex.net/Mobile/iOS/NFT/Pink/Lilo/3.png"
                ],
                rating: 2,
                price: 40.59,
                author: "John Doe",
                createdAt: nil,
                description: "Test description",
                website: nil
            ),
            rating: 2
        )
    }
}
