//
//  UserNftTokensLink.swift
//  iOS-FakeNFT-Extended
//
//  Created by Вадим Суханов on 09.12.2025.
//
import SwiftUI

struct UserNftTokensLink: View {
    let nftCount: Int
    
    init(nftCount: Int) {
        self.nftCount = nftCount
    }
    
    var body: some View {
        HStack {
            Text("\(Constants.nftTokenLinkTitle) (\(nftCount))")
            Spacer()
            Image(systemName: "chevron.forward")
        }
        .frame(height: 54)
        .font(Font.system(size: 17, weight: .bold))
        .foregroundStyle(.ypBlack)        
    }
    enum Constants {
        static let nftTokenLinkTitle = NSLocalizedString("UserNftTokensLink.title", comment: "")
    }
}
