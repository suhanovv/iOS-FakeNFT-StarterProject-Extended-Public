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
            
            Text(Constants.emptyFavNFT)
                .font(.system(size: 17, weight: .bold))
                .foregroundColor(.ypBlack)
            
            Spacer()
        }
    }
}

private enum Constants {
    static let emptyFavNFT = NSLocalizedString("Profile.emptyFavNft", comment: "")
}

// MARK: - Preview_
#Preview {
    NavigationStack {
        FavNFTEmptyView()
    }
}
