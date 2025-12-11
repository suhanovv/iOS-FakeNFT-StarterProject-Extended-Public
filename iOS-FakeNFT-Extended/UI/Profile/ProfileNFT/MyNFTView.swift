//
//  MyNFTView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Ди Di on 11/12/25.
//

import SwiftUI

struct MyNFTView: View {
    let nft: NftItem
    let rating: Int
        
    @AppStorage("favorite_nft_ids") private var rawFavoriteIds: Data = Data()
    
    var favoriteIds: [String] {
        (try? JSONDecoder().decode([String].self, from: rawFavoriteIds)) ?? []
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
                toggleFavorite()
            } label: {
                Image(systemName: isFavorite ? "heart.fill" : "heart.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 17, height: 15)
                    .padding(12)
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
        .frame(width: 108, height: 108)
        .clipShape(RoundedRectangle(cornerRadius: 12))
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
        HStack(spacing: 2) {
            ForEach(0..<5) { index in
                Image(systemName: "star.fill")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(index < rating ? .ypYellowUniversal : .ypLightGray)
                    .frame(width: 12, height: 12)
            }
        }
    }
    
    private var nftPriceSection: some View {
        VStack(alignment: .leading) {
            Text("Цена")
                .font(Font(UIFont.caption2))
                .foregroundColor(.ypBlack)
            
            Text(String(format: "%.2f ETH", nft.price ?? 0))
                .font(Font(UIFont.bodyBold))
                .foregroundColor(.ypBlack)
        }
    }
    
    func setFavoriteIds(_ newValue: [String]) {
        rawFavoriteIds = (try? JSONEncoder().encode(newValue)) ?? Data()
    }
    
    func toggleFavorite() {
        var ids = favoriteIds
        if ids.contains(nft.id) {
            ids.removeAll { $0 == nft.id }
        } else {
            ids.append(nft.id)
        }
        setFavoriteIds(ids)
    }
}

#Preview {
    NavigationStack {
        MyNFTView(
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
