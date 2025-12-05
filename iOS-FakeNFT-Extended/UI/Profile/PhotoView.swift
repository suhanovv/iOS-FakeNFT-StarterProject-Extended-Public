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
                }
            }
        }
        .clipShape(Circle())
    }
}
