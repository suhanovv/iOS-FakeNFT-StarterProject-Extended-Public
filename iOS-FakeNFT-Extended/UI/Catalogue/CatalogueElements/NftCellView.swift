//
//  NftCellView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Diana Viter on 09.12.2025.
//


import SwiftUI

// MARK: - NftCellView

struct NftCellView: View {
    
    // MARK: - Properties
    
    let name: String
    let price: Decimal
>>>>>>> 427e8ea (feat(catalogue): add catalogue & collection UI, DTOs and navigation)
    let rating: Int
    let imageURL: URL?

    @State private var isFavorite: Bool
    @State private var isInCart: Bool
    
    // MARK: - Init
    
    init(
        name: String,
        price: Decimal,
>>>>>>> 427e8ea (feat(catalogue): add catalogue & collection UI, DTOs and navigation)
        rating: Int,
        imageURL: URL?,
        isFavorite: Bool = false,
        isInCart: Bool = false
    ) {
        self.name = name
        self.price = price
        self.rating = rating
        self.imageURL = imageURL
        _isFavorite = State(initialValue: isFavorite)
        _isInCart = State(initialValue: isInCart)
    }
<<<<<<< HEAD
    
    // MARK: - Body

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            nftImageSection
            ratingSection
            infoSection
        }
        .frame(alignment: .leading)
    }
    
    // MARK: - Views

    private var nftImageSection: some View {
        ZStack(alignment: .topTrailing) {
            if let url = imageURL {
                KFImage(url)
                    .resizable()
                    .scaledToFill()
                    .clipped()
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                
=======

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            nftImageSection
            ratingSection
            infoSection
        }
        .frame(alignment: .leading)
>>>>>>> 427e8ea (feat(catalogue): add catalogue & collection UI, DTOs and navigation)
    }
    
    // MARK: - Views

    private var nftImageSection: some View {
        ZStack(alignment: .topTrailing) {
            Image(.nftCell)
                .resizable()
                .scaledToFill()
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))

            Button(action: onFavoriteTap) {
                Image("Nft Card Icons/Like")
                    .renderingMode(.template)
                    .foregroundStyle(isFavorite ? .ypRedUniversal : .ypWhiteUniversal)
            }
        }
    }

    private var ratingSection: some View {
        HStack(spacing: 2) {
            ForEach(0..<5, id: \.self) { index in
                Image(systemName: "star.fill")
                    .font(.caption)
                    .foregroundColor(index < rating ? .ypYellowUniversal : .gray.opacity(0.1))
            }
        }
    }

    private var infoSection: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(name)
                    .font(.init(UIFont.bodyBold))

                Text("\(price) ETH")
                    .font(.caption)
            }

            Spacer()

            Button(action: onCartTap) {
                Image(isInCart ? "Nft Card Icons/CartDelete" : "Nft Card Icons/CartAdd")
                    .foregroundStyle(.ypBlackUniversal)
            }
        }
    }
    
    // MARK: - Actions

    private func onFavoriteTap() {
        isFavorite.toggle()
    }

    private func onCartTap() {
        isInCart.toggle()
    }
}

// MARK: - Preview_NftCellView

#Preview {
    NftCellView(
        name: "Archie",
        price: 1,
        rating: 3,
        imageURL: nil,
        isFavorite: true,
        isInCart: true
    )
    .frame(width: 108, height: 108)
}
