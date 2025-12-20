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
    @AppStorage(StorageKeys.favouriteNFTIds) private var favouritesMarker: Data = Data()
    
    @Environment(Coordinator.self) private var coordinator
    
    @State private var viewModel = ProfileViewModel(profileService: ProfileServiceMock())
    
    private var photoURL: URL? {
        viewModel.photoURL(savedPhotoURL: savedPhotoURL)
    }
    
    private var myNFTCount: Int {
        ProfileViewMock.mockNFTs.count
    }
    
    private var favNFTCount: Int {
        let favouriteIds = (try? JSONDecoder().decode([String].self, from: favouritesMarker)) ?? []
        return ProfileViewMock.mockNFTs.filter {
            favouriteIds.contains($0.id)
        }.count
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
            Button {
                coordinator.push(.webView(url: url))
            } label: {
                Text(url.host ?? storedWebsite)
                    .font(Font(UIFont.caption1))
                    .foregroundColor(.ypBlueUniversal)
                    .underline()
            }
            .buttonStyle(.plain)
        }
    }
    
    private var listRows: some View {
        List {
            ProfileListRow(title: Constants.myNFT, count: myNFTCount) {
                coordinator.push(.myNft)
            }
            ProfileListRow(title: Constants.favouriteNFT, count: favNFTCount) {
                coordinator.push(.favouriteNft)
            }
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
        .padding(.top, 40)
    }
}

private enum Constants {
    static let myNFT = NSLocalizedString("Profile.myNFT", comment: "")
    static let favouriteNFT = NSLocalizedString("Profile.favouriteNFT", comment: "")
}

// MARK: - Preview_ProfileView
#Preview("Profile – filled") {
    let services = ServicesAssembly(networkClient: DefaultNetworkClient(), nftStorage: NftStorageImpl())
    NavigationStack {
        ProfileView()
            .environment(Coordinator(services: services))
            .onAppear {
                UserDefaults.standard.set("Joaquin Phoenix", forKey: StorageKeys.name)
                UserDefaults.standard.set(
                    "Дизайнер из Казани, люблю цифровое искусство и бейглы. В моей коллекции уже 100+ NFT, и еще больше — на моём сайте. Открыт к коллаборациям.",
                    forKey: StorageKeys.description
                )
                UserDefaults.standard.set("https://joaquinphoenix.com", forKey: StorageKeys.website)
                UserDefaults.standard.set("https://picsum.photos/id/237/200/200", forKey: StorageKeys.photoURL)
            }
    }
}
