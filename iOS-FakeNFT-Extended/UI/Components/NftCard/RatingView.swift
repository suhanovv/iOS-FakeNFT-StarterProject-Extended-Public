//
//  RatingView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Вадим Суханов on 05.12.2025.
//

import SwiftUI

struct RatingView: View {
    let rating: Int
    var body: some View {
        HStack(spacing: 0) {
            ForEach(1..<6) { index in
                Image(systemName: "star.fill").font(Font.system(size: 12))
                    .foregroundColor(index <= self.rating ? .ypYellowUniversal : .ypLightGray)
            }
        }
    }
}

#Preview {
    RatingView(rating: 3)
}
