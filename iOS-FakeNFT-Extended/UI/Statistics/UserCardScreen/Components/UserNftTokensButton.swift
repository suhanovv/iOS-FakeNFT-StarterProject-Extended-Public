//
//  UserNftTokensButton.swift
//  iOS-FakeNFT-Extended
//
//  Created by Вадим Суханов on 09.12.2025.
//
import SwiftUI

struct UserNftTokensButton: View {
    let nftCount: Int
    
    init(nftCount: Int) {
        self.nftCount = nftCount
    }
    
    var body: some View {
        Button(action: {}) {
            HStack {
                Text("\(Constants.nftTokenLinkTitle) (\(nftCount))")
                Spacer()
                Image(systemName: "chevron.forward")
            }
            .font(Font.system(size: 17, weight: .bold))
            .foregroundStyle(.ypBlack)
        }
        
    }
}

private enum Constants {
    static let nftTokenLinkTitle = NSLocalizedString("UserProfile.nftTokenLink.title", comment: "")
    
}

#Preview {
    UserNftTokensButton(nftCount: 10)
}
