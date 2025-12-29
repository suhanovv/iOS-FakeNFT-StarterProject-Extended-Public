//
//  NFTImageView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Ди Di on 17/12/25.
//

import SwiftUI
import Kingfisher

struct NFTImageView: View {
    let imageURL: String?
    let placeholder: Image
    
    var body: some View {
        Group {
            if let imageURL,
               let url = URL(string: imageURL) {
                
                KFImage(url)
                    .placeholder {
                        ZStack {
                            placeholder.opacity(0.3)
                            ProgressView()
                                .tint(.ypBlack)
                                .scaleEffect(1.5)
                        }
                    }
                    .retry(maxCount: 2, interval: .seconds(1))
                    .cacheOriginalImage()
                    .fade(duration: 0.2)
                    .resizable()
                    .scaledToFill()
                
            } else {
                placeholder
                    .resizable()
                    .scaledToFill()
            }
        }
    }
}
