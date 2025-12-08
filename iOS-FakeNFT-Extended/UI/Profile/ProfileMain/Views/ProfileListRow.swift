//
//  ProfileListRow.swift
//  iOS-FakeNFT-Extended
//
//  Created by Ди Di on 05/12/25.
//

import SwiftUI

struct ProfileListRow: View {
    let title: String
    let count: Int
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Text(title)
                    .font(Font(UIFont.bodyBold))
                    .foregroundColor(.ypBlack)
                
                Text("(\(count))")
                    .font(Font(UIFont.bodyBold))
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.ypBlack)
            }
            .contentShape(Rectangle())
        }
        .listRowSeparator(.hidden)
        .listRowInsets(EdgeInsets())
        .listRowBackground(Color.clear)
    }
}

// MARK: - Preview_ProfileListRow
#Preview {
    VStack(spacing: 16) {
        ProfileListRow(
            title: "Мои NFT",
            count: 12,
            action: {}
        )

        ProfileListRow(
            title: "Избранное",
            count: 3,
            action: {}
        )

        ProfileListRow(
            title: "Пустой список",
            count: 0,
            action: {}
        )
    }
    .padding()
    .background(Color(.systemGroupedBackground))
}
