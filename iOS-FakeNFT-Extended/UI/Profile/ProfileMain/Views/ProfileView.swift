//
//  ProfileView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Ди Di on 08/12/25.
//

import SwiftUI

struct ProfileView: View {
    // MARK: - AppStorage
    @AppStorage("profile_name") private var storedName: String = ""
    @AppStorage("profile_description") private var storedDescription: String = ""
    @AppStorage("profile_website") private var storedWebsite: String = ""
    @AppStorage(Constants.StorageKeys.photoURL) private var savedPhotoURL: String = ""
    
    @State private var isEditing = false
    
    var photoURL: URL? { URL(string: savedPhotoURL) }
    
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
            ProfileEditView()
                .toolbar(.hidden, for: .tabBar)
        }
        .toolbar {
            navigationToolbar
        }
    }
    
    // MARK: - Views
    private var nameRow: some View {
        Text(storedName)
            .font(Font(UIFont.headline3))
            .foregroundColor(.ypBlack)
    }
    
    private var descriptionRow: some View {
        Text(storedDescription)
            .font(Font(UIFont.caption2))
            .foregroundColor(.ypBlack)
            .padding(.bottom, 8)
    }
    
    private var webRow: some View {
        Link(storedWebsite, destination: URL(string: "https://\(storedWebsite)")!)
            .font(Font(UIFont.caption1))
            .foregroundColor(.ypBlueUniversal)
            .underline()
    }
    
    private var listRows: some View {
        List {
            ProfileListRow(title: Constants.Titles.myNFT, count: 21) {
                // add action
            }
            
            ProfileListRow(title: Constants.Titles.favouriteNFT, count: 21) {
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
        ProfileView()
            .onAppear {
                UserDefaults.standard.set("Joaquin Phoenix", forKey: "profile_name")
                UserDefaults.standard.set("Дизайнер из Казани, люблю цифровое искусство и бейглы. В моей коллекции уже 100+ NFT, и еще больше — на моём сайте. Открыт к коллаборациям.", forKey: "profile_description")
                UserDefaults.standard.set("JoaquinPhoenix.com", forKey: "profile_website")
                UserDefaults.standard.set("https://picsum.photos/id/237/200/200", forKey: Constants.StorageKeys.photoURL)
            }
    }
}
