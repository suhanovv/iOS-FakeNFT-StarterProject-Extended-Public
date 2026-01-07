//
//  FavNFTView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Ди Di on 12/12/25.
//

import SwiftUI

struct FavNFTView: View {
    @State private var viewModel: FavNFTViewModel
    
    init(viewModel: FavNFTViewModel) {
        _viewModel = State(initialValue: viewModel)
    }
    
    let columns = [
        GridItem(.flexible(minimum: 0), spacing: 20),
        GridItem(.flexible(minimum: 0), spacing: 20)
    ]
    
    var body: some View {
        content
            .navigationBarBackButtonHidden(true)
            .navigationBarTitleDisplayMode(.inline)
            .ignoresSafeArea(.container, edges: .bottom)
            .toolbarBackground(.hidden, for: .bottomBar)
            .toolbar { toolbarContent }
            .overlay(loadingOverlay)
            .task {
                await viewModel.loadData()
            }
            .alert(
                Constants.errorTitle,
                isPresented: $viewModel.showErrorAlert
            ) {
                Button(Constants.cancel, role: .cancel) {
                    viewModel.showErrorAlert = false
                }
                Button(Constants.retry) {
                    viewModel.showErrorAlert = false
                    Task {
                        if case .error(let operation) = viewModel.state {
                            await viewModel.retry(operation)
                        }
                    }
                }
            } message: {
                Text(viewModel.errorMessage)
            }
    }
    
    @ViewBuilder
    private var content: some View {
        if viewModel.isInitialLoading {
            Color.clear
        } else {
            switch viewModel.state {
                
            case .loading:
                Color.clear
                
            case .empty:
                FavNFTEmptyView()
                
            case .loaded:
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(viewModel.nfts) { nft in
                            FavNFTCell(
                                nft: nft,
                                rating: nft.rating,
                                isFavourite: viewModel.likedIds.contains(nft.id),
                                onLikeTap: {
                                    Task {
                                        await viewModel.toggleLike(nftId: nft.id)
                                    }
                                }
                            )
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 20)
                }
            case .error:
                Color.clear
            }
        }
    }
    
    private var toolbarContent: some ToolbarContent {
        Group {
            if !viewModel.nfts.isEmpty || viewModel.isInitialLoading {
                ToolbarItem(placement: .principal) {
                    Text(Constants.favouriteNFT)
                        .font(.system(size: 17, weight: .bold))
                }
            }
        }
    }
    
    private var loadingOverlay: some View {
        ProgressBarView(
            isActive: viewModel.isInitialLoading || viewModel.isLikeUpdating
        )
    }
}

private enum Constants {
    static let favouriteNFT = NSLocalizedString("Profile.favouriteNFT", comment: "")
    static let errorTitle = NSLocalizedString("Profile.error.title", comment: "")
    static let retry  = NSLocalizedString("Profile.retryButton", comment: "")
    static let cancel = NSLocalizedString("Profile.cancelButton", comment: "")
}

// MARK: - Preview_FavNFTView
#if DEBUG
extension Profile {
    init(
        name: String,
        avatar: URL?,
        description: String?,
        website: URL?,
        nfts: [String],
        likes: [String],
        id: String
    ) {
        self.name = name
        self.avatar = avatar
        self.description = description
        self.website = website
        self.nfts = nfts
        self.likes = likes
        self.id = id
    }
}
#endif
#if DEBUG
final class PreviewFavProfileService: ProfileServiceProtocol {
    private let profile = Profile(
        name: "Preview User",
        avatar: nil,
        description: nil,
        website: nil,
        nfts: ["1", "2", "3", "4"],
        likes: ["1", "2"],
        id: "preview-id"
    )
    func getProfile() async throws -> Profile {
        profile
    }
    func updateProfile(_ request: ProfileUpdateRequest) async throws -> Profile {
        profile
    }
    func getProfileLikes() async throws -> [String] {
        profile.likes
    }
    func addLikeForNft(_ nftId: String) async throws -> [String] {
        profile.likes + [nftId]
    }
    func removeLikeFromNft(_ nftId: String) async throws -> [String] {
        profile.likes.filter { $0 != nftId }
    }
}
final class PreviewFavNftService: NftService {
    func loadNft(id: String) async throws -> Nft {
        Nft(
            id: id,
            images: [
                URL(string: "https://picsum.photos/200")!
            ],
            rating: 4,
            price: 12.5,
            name: "Preview NFT \(id)",
            author: "Preview Author",
            createdAt: "2024-01-01",
            description: "Preview description"
        )
    }
}
#Preview {
    let viewModel = FavNFTViewModel(
        nftService: PreviewFavNftService(),
        profileService: PreviewFavProfileService(),
        nftIds: ["1", "2", "3", "4"]
    )

    NavigationStack {
        FavNFTView(viewModel: viewModel)
    }
}
#endif
