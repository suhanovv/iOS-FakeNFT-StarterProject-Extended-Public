//
//  ProfileView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Ди Di on 04/12/25.
//

import SwiftUI

struct ProfileView: View {
    var photoURL: URL?
    var name: String
    var description: String
    var website: String
    @State private var isEditing = false
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center, spacing: 16) {
                PhotoView(url: photoURL)
                
                Text(name)
                    .font(Font(UIFont.headline3))
                    .foregroundColor(.ypBlack)
                Spacer()
            }
            .padding(.vertical, 20)
        
            Text(description)
                .font(Font(UIFont.caption2))
                .foregroundColor(.ypBlack)
                .padding(.bottom, 8)
            
            Link(website, destination: URL(string: "https://\(website)")!)
                .font(Font(UIFont.caption1))
                .foregroundColor(.ypBlueUniversal)
                .underline()
            
            List {
                ProfileListRow(title: "Мои NFT", count: 21) {
                    // add action
                }
    
                ProfileListRow(title: "Избранные NFT", count: 21) {
                    // add action
                }
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
            .padding(.top, 40)
        }
        .padding(.horizontal, 16)
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(isPresented: $isEditing) {
            EditProfileView(
                name: name,
                description: description,
                website: website,
                photoURL: photoURL
            )
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    isEditing = true
                } label: {
                    Image(systemName: "square.and.pencil")
                        .font(.system(size: 26))
                        .foregroundColor(.ypBlack)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        ProfileView(
            photoURL: URL(string: "https://picsum.photos/id/237/200/200"),
            name: "Joaquin Phoenix",
            description: "Дизайнер из Казани, люблю цифровое искусство и бейглы. В моей коллекции уже 100+ NFT, и еще больше — на моём сайте. Открыт к коллаборациям.",
            website: "JoaquinPhoenix.com"
        )
    }
}
