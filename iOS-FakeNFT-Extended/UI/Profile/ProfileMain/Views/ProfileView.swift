//
//  ProfileView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Ди Di on 08/12/25.
//

import SwiftUI

struct ProfileView: View {
    @Environment(Coordinator.self) private var coordinator
    @State private var viewModel: ProfileViewModel
    
    init(profileService: ProfileServiceProtocol) {
        _viewModel = State(
            initialValue: ProfileViewModel(profileService: profileService)
        )
    }
    
    // MARK: - Body
    var body: some View {
        ZStack {
            if viewModel.isLoading {
                ProgressBarView(isActive: true)
            } else {
                content
            }
        }
        .task {
            coordinator.isProfileLoading = true
            defer { coordinator.isProfileLoading = false }
            
            await viewModel.loadProfile()
            coordinator.currentProfile = viewModel.profile
        }
        .onAppear {
            coordinator.isOnProfileScreen = true
        }
        .onDisappear {
            coordinator.isOnProfileScreen = false
        }
    }
    
    // MARK: - Views
    private var content: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center, spacing: 16) {
                ProfilePhotoView(url: viewModel.avatarURL)
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
    
    private var nameRow: some View {
        Text(viewModel.name)
            .font(Font(UIFont.headline3))
            .foregroundColor(.ypBlack)
    }
    
    @ViewBuilder
    private var descriptionRow: some View {
        if !viewModel.description.isEmpty {
            Text(viewModel.description)
                .font(Font(UIFont.caption2))
                .foregroundColor(.ypBlack)
                .padding(.bottom, 8)
        }
    }
    
    @ViewBuilder
    private var webRow: some View {
        if let url = viewModel.websiteURL {
            Button {
                coordinator.push(.webView(url: url))
            } label: {
                Text(url.host ?? url.absoluteString)
                    .font(Font(UIFont.caption1))
                    .foregroundColor(.ypBlueUniversal)
                    .underline()
            }
            .buttonStyle(.plain)
        }
    }
    
    private var listRows: some View {
        List {
            ProfileListRow(
                title: Constants.myNFT,
                count: viewModel.myNFTCount
            ) {
                guard let profile = viewModel.profile else { return }
                coordinator.push(.myNft(ids: profile.nfts))
            }
            
            ProfileListRow(
                title: Constants.favouriteNFT,
                count: viewModel.favouriteNFTCount
            ) {
                guard let profile = viewModel.profile else { return }
                coordinator.push(.favouriteNft(ids: profile.likes))
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
#if DEBUG
struct EditProfilePreviewService: ProfileServiceProtocol {
    func getProfile() async throws -> User {
        User(
            name: "Preview User",
            avatarRaw: "https://fastly.picsum.photos/id/237/100/100.jpg",
            description: "Preview description",
            websiteRaw: "https://example.com",
            nfts: ["1", "2", "3"],
            likes: ["2"],
            rating: 5,
            id: "preview-id"
        )
    }
    func getProfileLikes() async throws -> [String] { ["2"] }
    func addLikeForNft(_ nftId: String) async throws -> [String] { ["2", nftId] }
    func removeLikeFromNft(_ nftId: String) async throws -> [String] { [] }
    func updateProfile(_ request: ProfileUpdateRequest) async throws -> User { try await getProfile() }
}
#endif
#Preview {
    NavigationStack {
        ProfileView(
            profileService: EditProfilePreviewService()
        )
        .environment(
            Coordinator(
                services: ServicesAssembly(
                    networkClient: DefaultNetworkClient(),
                    nftStorage: NftStorageImpl()
                )
            )
        )
    }
}
