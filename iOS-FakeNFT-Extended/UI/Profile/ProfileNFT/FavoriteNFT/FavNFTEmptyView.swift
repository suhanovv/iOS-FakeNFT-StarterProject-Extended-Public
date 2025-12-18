//
//  FavNFTEmptyView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Ди Di on 18/12/25.
//

import SwiftUI

struct FavNFTEmptyView: View {
    var body: some View {
        VStack {
            Spacer()
            
            Text("У Вас ещё нет избранных NFT")
                .font(Font(UIFont.bodyBold))
                .foregroundColor(.ypBlack)
            
            Spacer()
        }
    }
}

#Preview {
    NavigationStack {
        FavNFTEmptyView()
    }
}
