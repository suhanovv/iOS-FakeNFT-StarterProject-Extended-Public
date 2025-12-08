//
//  PhotoView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Ди Di on 05/12/25.
//

import SwiftUI

struct PhotoView: View {
    let url: URL?
    
    var body: some View {
        ZStack {
            Color.ypBlack
            if let url = url {
                AsyncImage(url: url) { image in
                    image.resizable().scaledToFill()
                } placeholder: {
                    ProgressView()
                        .tint(Color.ypWhite)
                        .scaleEffect(1.5)
                }
            }
            else {
                ZStack {
                    Circle()
                        .fill(Color.ypLightGray)
                    Image(.CommonIcons.emptyProfile)
                }
            }
        }
        .clipShape(Circle())
        .frame(width: 70, height: 70)
    }
}
