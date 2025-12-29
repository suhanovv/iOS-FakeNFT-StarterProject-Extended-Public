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
