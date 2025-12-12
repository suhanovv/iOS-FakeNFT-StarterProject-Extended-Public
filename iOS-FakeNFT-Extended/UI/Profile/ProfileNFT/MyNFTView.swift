//
//  MyNFTView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Ди Di on 12/12/25.
//

import SwiftUI

// MARK: - Constants
private enum Constants {
    // Titles
    static let title = "Мои NFT"
    
    // Dialog
}

struct MyNFTView: View {
    let nfts: [NftItem]
    
    var body: some View {
        List {
            ForEach(nfts) { nft in
                MyNFTCell(nft: nft, rating: nft.rating ?? 0)
                    .padding(.leading, 16)
                    .padding(.trailing, 39)
                    .padding(.vertical, 16)
                    .listRowInsets(EdgeInsets())
                    .listRowSeparator(.hidden)
            }
        }
        .listStyle(.plain)
        .padding(.vertical, 20)
    }
}

// MARK: - Preview_MyNFTView
#Preview {
    NavigationStack {
        MyNFTView(nfts: ProfileViewMock.mockNFTs)
    }
}
