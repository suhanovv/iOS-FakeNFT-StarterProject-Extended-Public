//
//  NFTRatingView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Ди Di on 17/12/25.
//

import SwiftUI

struct NFTRatingView: View {
    let rating: Int
    
    var body: some View {
        HStack(spacing: 2) {
            ForEach(0..<5) { index in
                Image(systemName: "star.fill")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(
                        index < rating
                        ? .ypYellowUniversal
                        : .ypLightGray
                    )
                    .frame(width: 12, height: 12)
            }
        }
    }
}
