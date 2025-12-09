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

#Preview("no avatar") {
    StatisticsUserCard(avatar: nil, name: "Bob", description: "With a keen eye for emerging trends and a commitment to authenticity, I offer a diverse collection of digital assets that cater to collectors and investors alike.")
}

#Preview("has avatar") {
    StatisticsUserCard(avatar: URL(string: "https://n1s2.hsmedia.ru/10/07/5b/10075bc9f87787e109c8bd9d93e8d66b/600x400_0x0a330c9a_8308133731545062329.jpeg"), name: "Bob", description: "With a keen eye for emerging trends and a commitment to authenticity, I offer a diverse collection of digital assets that cater to collectors and investors alike.")
}
