//
//  ProfileView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Ди Di on 04/12/25.
//

import SwiftUI

struct ProfileHeaderView: View {
    var photoURL: URL?
    var name: String
    var description: String
    var website: String
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center, spacing: 16) {
                PhotoView(url: photoURL)
                    .frame(width: 70, height: 70)
                    .clipShape(Circle())

                Text(name)
                    .font(Font(UIFont.headline3))
                    .foregroundColor(.ypBlack)

                Spacer()
            }
            .padding(.bottom, 20)

            Text(description)
                .font(Font(UIFont.caption2))
                .foregroundColor(.ypBlack)
                .padding(.bottom, 8)

            Link(website, destination: URL(string: "https://\(website)")!)
                .font(Font(UIFont.caption1))
                .foregroundColor(.ypBlueUniversal)
                .underline()
        }
        .padding(.horizontal, 16)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    // add action
                } label: {
                    Image(systemName: "square.and.pencil")
                        .font(.system(size: 26))
                        .foregroundColor(.ypBlack)
                }
            }
        }
    }
}

struct PhotoView: View {
    let url: URL?
    
    var body: some View {
        ZStack {
            Color.ypGrayUniversal.opacity(0.2)
            if let url = url {
                AsyncImage(url: url) { image in
                    image.resizable().scaledToFill()
                } placeholder: {
                    ProgressView()
                }
            }
        }
        .clipShape(Circle())
    }
}

#Preview {
    NavigationStack {
        ProfileHeaderView(
            photoURL: URL(string: "https://picsum.photos/id/237/200/200"),
            name: "Joaquin Phoenix",
            description: "Дизайнер из Казани, люблю цифровое искусство и бейглы. В моей коллекции уже 100+ NFT, и еще больше — на моём сайте. Открыт к коллаборациям.",
            website: "JoaquinPhoenix.com"
        )
    }
}
