//
//  MyNFTEmptyView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Ди Di on 18/12/25.
//

import SwiftUI

struct MyNFTEmptyView: View {
    var body: some View {
        VStack {
            Spacer()
            
            Text(Constants.emptyMyNFT)
                .font(Font(UIFont.bodyBold))
                .foregroundColor(.ypBlack)
            
            Spacer()
        }
    }
}

private enum Constants {
    static let emptyMyNFT = NSLocalizedString("Profile.emptyMyNft", comment: "")
}

#Preview {
    NavigationStack {
        MyNFTEmptyView()
    }
}
