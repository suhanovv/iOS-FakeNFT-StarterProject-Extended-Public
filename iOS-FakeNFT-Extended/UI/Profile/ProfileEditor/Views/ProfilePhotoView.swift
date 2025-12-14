//
//  ProfilePhotoView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Ди Di on 05/12/25.
//

import SwiftUI

struct ProfilePhotoView: View {
    let url: URL?
    
    // MARK: - Body
    var body: some View {
        ZStack {
            Color.ypBlack
            avatarContent
        }
        .clipShape(Circle())
        .frame(width: 70, height: 70)
    }
    
    // MARK: - Views
    private var avatarContent: some View {
        Group {
            if let url {
                remoteImage
            } else {
                placeholder
            }
        }
    }
    
    private var remoteImage: some View {
        AsyncImage(url: url) { image in
            image.resizable().scaledToFill()
        } placeholder: {
            ProgressView()
                .tint(.ypWhite)
                .scaleEffect(1.5)
        }
    }
    
    private var placeholder: some View {
        Circle()
            .fill(Color.ypLightGray)
            .overlay(Image(.CommonIcons.emptyProfile))
    }
}

// MARK: - Preview_ProfilePhotoView
#Preview("ProfilePhotoView States") {
    VStack(spacing: 24) {
        // С фото
        ProfilePhotoView(url: URL(string: "https://picsum.photos/id/237/200/200"))
        
        // Без фото (отображается плейсхолдер)
        ProfilePhotoView(url: nil)
    }
    .padding()
    .background(Color(.systemBackground))
}
