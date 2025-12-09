//
//  ProfileView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Ди Di on 08/12/25.
//

import SwiftUI

struct ProfileView: View {
    @AppStorage(ProfileStorageKeys.photoURL) private var savedPhotoURL: String = ""
    
    var photoURL: URL? { URL(string: savedPhotoURL) }
    var name: String
    var description: String
    var website: String
    
    @State private var isEditing = false
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center, spacing: 16) {
                ProfilePhotoView(url: photoURL)
                nameRow
                Spacer()
            }
            .padding(.vertical, 20)
            
            descriptionRow
            webRow
            listRows
        }
        .padding(.horizontal, 16)
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(isPresented: $isEditing) {
            ProfileEditView(
                name: name,
                description: description,
                website: website,
            )
            .toolbar(.hidden, for: .tabBar)
        }
        .toolbar {
            navigationToolbar
        }
    }
    
    // MARK: - Views
    private var nameRow: some View {
        Text(name)
            .font(Font(UIFont.headline3))
            .foregroundColor(.ypBlack)
    }
    
    private var descriptionRow: some View {
        Text(description)
            .font(Font(UIFont.caption2))
            .foregroundColor(.ypBlack)
            .padding(.bottom, 8)
    }
    
    private var webRow: some View {
        Link(website, destination: URL(string: "https://\(website)")!)
            .font(Font(UIFont.caption1))
            .foregroundColor(.ypBlueUniversal)
            .underline()
    }
    
    private var listRows: some View {
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
    
    // MARK: - Toolbar
    private var navigationToolbar: some ToolbarContent {
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

// MARK: - Preview_ProfileView
#Preview {
    NavigationStack {
        ProfileView(
            name: "Joaquin Phoenix",
            description: "Дизайнер из Казани, люблю цифровое искусство и бейглы. В моей коллекции уже 100+ NFT, и еще больше — на моём сайте. Открыт к коллаборациям.",
            website: "JoaquinPhoenix.com"
        )
    }
}
