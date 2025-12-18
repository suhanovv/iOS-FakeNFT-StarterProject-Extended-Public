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
            
            Text("У Вас ещё нет NFT")
                .font(Font(UIFont.bodyBold))
                .foregroundColor(.ypBlack)
            
            Spacer()
        }
    }
}

#Preview {
    NavigationStack {
        MyNFTEmptyView()
    }
}
