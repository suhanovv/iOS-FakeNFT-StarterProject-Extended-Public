//
//  IconsView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Вадим Суханов on 02.12.2025.
//

import SwiftUI

struct IconsView: View {
    var body: some View {
        VStack {
            Image(.CommonIcons.close)
            Image(.CommonIcons.sort)
            Image(.NftCardIcons.cartAdd)
            Image(.NftCardIcons.cartDelete)
            Image(.NftCardIcons.like).foregroundStyle(.ypRedUniversal)
            Image(systemName: "star.fill").foregroundStyle(.ypYellowUniversal)
        }
    }
}

#Preview {
    IconsView()
}
