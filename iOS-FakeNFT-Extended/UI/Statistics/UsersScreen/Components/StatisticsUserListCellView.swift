//
//  StatisticsUserListCellView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Вадим Суханов on 04.12.2025.
//

import SwiftUI
import Kingfisher

struct StatisticsUserListCellView: View {
    let rowNumber: Int
    let userName: String
    let rating: Int
    let avatarUrl: URL?
    var body: some View {
        HStack {
            Text("\(rowNumber)")
                .frame(width: 35)
                .font(.system(size: 15, weight: .regular))
                .multilineTextAlignment(.center)
            HStack {
                KFImage(avatarUrl)
                    .placeholder { Image(.StatisticsIcons.blankUserpick) }
                    .resizable()
                    .scaledToFill()
                    .frame(width: 28, height: 28)
                    .clipShape(.circle)
                    .padding(.leading, 16)

                Text(userName)
                    .lineLimit(1)
                    .font(.system(size: 22, weight: .bold))
                Spacer()
                Text("\(rating)")
                    .font(.system(size: 22, weight: .bold))
                    .padding(.trailing, 26)
            }
            .frame(height: 80)
            .background(.ypLightGray)
            .clipShape(.rect(cornerRadius: 12))
        }
        
        .listRowSeparator(.hidden)
        .listRowBackground(Color.ypWhite)
        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
    }
}

#Preview {
    StatisticsUserListCellView(rowNumber: 1, userName: "Mads", rating: 6, avatarUrl: URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/f/f7/Brendan_Fraser_October_2022.jpg/1200px-Brendan_Fraser_October_2022.jpg"))
    StatisticsUserListCellView(rowNumber: 200, userName: "Bad avatar", rating: 1, avatarUrl: URL(string: "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/740.jpg"))
    StatisticsUserListCellView(rowNumber: 999, userName: "No avatar", rating: 1, avatarUrl: nil)
}
