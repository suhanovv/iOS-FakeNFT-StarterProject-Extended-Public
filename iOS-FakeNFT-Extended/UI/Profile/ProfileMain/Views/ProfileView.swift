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
        .onAppear {
            Task {
                await viewModel.loadProfile()
            }
        }
    }
    
    // MARK: - Views
    private var content: some View {
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Spacer()
                    Button {
                        guard let profile = viewModel.profile else { return }
                        coordinator.push(.profileEdit(profile))
                    } label: {
                        Image(systemName: "square.and.pencil")
                            .font(.system(size: 26, weight: .medium))
                            .foregroundColor(.ypBlack)
                    }
                    .padding(.trailing, -16)
                }
                .padding(.top, 8)
                .padding(.horizontal, 16)

                if let profile = viewModel.profile {
                    ProfileHeaderView(profile: profile)
                        .padding(.top, 12)
                }

                descriptionRow
                webRow
                listRows
            }
            .padding(.horizontal, 16)
        }
    
    @ViewBuilder
    private var descriptionRow: some View {
        if !viewModel.description.isEmpty {
            Text(viewModel.description)
                .font(.system(size: 13, weight: .regular))
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
                    .font(.system(size: 15, weight: .regular))
                    .foregroundColor(.ypBlueUniversal)
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

//// MARK: - Preview_ProfileView
//#if DEBUG
//struct EditProfilePreviewService: ProfileServiceProtocol {
//    func getProfile() async throws -> Profile {
//        Profile(
//            name: "Preview User",
//            avatar: URL(string: "https://fastly.picsum.photos/id/237/100/100.jpg")!,
//            description: "Preview description",
//            website: URL(string: "https://example.com")!,
//            nfts: ["1", "2", "3"],
//            likes: ["2"],
//            id: "preview-id"
//        )
//    }
//    func updateProfile(_ request: ProfileUpdateRequest) async throws -> Profile {
//        try await getProfile()
//    }
//    func getProfileLikes() async throws -> [String] {
//        ["2"]
//    }
//    func addLikeForNft(_ nftId: String) async throws -> [String] {
//        ["2", nftId]
//    }
//    func removeLikeFromNft(_ nftId: String) async throws -> [String] {
//        []
//    }
//}
//#endif
//#Preview {
//    NavigationStack {
//        ProfileView(
//            profileService: EditProfilePreviewService()
//        )
//        .environment(
//            Coordinator(
//                services: ServicesAssembly(
//                    networkClient: DefaultNetworkClient(),
//                    nftStorage: NftStorageImpl()
//                )
//            )
//        )
//    }
//}
