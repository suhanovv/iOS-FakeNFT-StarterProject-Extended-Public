//
//  ProfileView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Ди Di on 08/12/25.
//

import SwiftUI

struct ProfileView: View {
    // MARK: - AppStorage
    @AppStorage(StorageKeys.name) private var storedName: String = ""
    @AppStorage(StorageKeys.description) private var storedDescription: String = ""
    @AppStorage(StorageKeys.website) private var storedWebsite: String = ""
    @AppStorage(StorageKeys.photoURL) private var savedPhotoURL: String = ""
    
    @State private var viewModel = ProfileViewModel()
    @State private var isMyNFTPresented = false
    
    private var photoURL: URL? {
        viewModel.photoURL(savedPhotoURL: savedPhotoURL)
    }
    
    private var myNFTCount: Int {
        ProfileViewMock.mockNFTs.count
    }
    
    // MARK: - Body
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
        .navigationDestination(isPresented: $viewModel.isEditing) {
            ProfileEditView(isEditing: $viewModel.isEditing)
                .toolbar(.hidden, for: .tabBar)
        }
        .navigationDestination(isPresented: $isMyNFTPresented) {
            MyNFTView(nfts: ProfileViewMock.mockNFTs)
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
    
    @ViewBuilder
    private var descriptionRow: some View {
        if !storedDescription.isEmpty {
            Text(storedDescription)
                .font(Font(UIFont.caption2))
                .foregroundColor(.ypBlack)
                .padding(.bottom, 8)
        }
    }
    
    @ViewBuilder
    private var webRow: some View {
        if let url = URL(string: storedWebsite) {
            Link(url.host ?? storedWebsite, destination: url)
                .font(Font(UIFont.caption1))
                .foregroundColor(.ypBlueUniversal)
                .underline()
        }
    }
    
    private var listRows: some View {
        List {
            ProfileListRow(title: Constants.myNFT, count: myNFTCount) {
                isMyNFTPresented = true
            }
            ProfileListRow(title: Constants.favouriteNFT, count: 21) {
                // action
            }
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
        .padding(.top, 40)
    }
    
    private var navigationToolbar: some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            Button {
                viewModel.isEditing = true
            } label: {
                Image(systemName: "square.and.pencil")
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundColor(.ypBlack)
            }
        }
    }
}

private enum Constants {
    static let myNFT = NSLocalizedString("Profile.myNFT", comment: "")
    static let favouriteNFT = NSLocalizedString("Profile.favouriteNFT", comment: "")
}

// MARK: - Preview_ProfileView
#Preview {
    NavigationStack {
        ProfileView()
            .onAppear {
                UserDefaults.standard.set("Joaquin Phoenix", forKey: "profile_name")
                UserDefaults.standard.set("Дизайнер из Казани, люблю цифровое искусство и бейглы. В моей коллекции уже 100+ NFT, и еще больше — на моём сайте. Открыт к коллаборациям.", forKey: "profile_description")
                UserDefaults.standard.set("JoaquinPhoenix.com", forKey: "profile_website")
                UserDefaults.standard.set("https://picsum.photos/id/237/200/200", forKey: StorageKeys.photoURL)
            }
    }
}
