//
//  StatisticsUserCard.swift
//  iOS-FakeNFT-Extended
//
//  Created by Вадим Суханов on 09.12.2025.
//

import SwiftUI
import Kingfisher

struct StatisticsUserCard: View {
    let avatar: URL?
    let name: String
    let description: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack(spacing: 16) {
                KFImage(avatar)
                    .placeholder { Image(.StatisticsIcons.blankProfileUserpic) }
                    .resizable()
                    .scaledToFill()
                    .frame(width: 70, height: 70)
                    .clipShape(.circle)
                
                Text(name)
                    .lineLimit(1)
                    .font(.system(size: 22, weight: .bold))
            }
            Text(description)
                .font(.system(size: 13, weight: .regular))
        }.frame(maxWidth: .infinity, alignment: .leading)
    }
}
