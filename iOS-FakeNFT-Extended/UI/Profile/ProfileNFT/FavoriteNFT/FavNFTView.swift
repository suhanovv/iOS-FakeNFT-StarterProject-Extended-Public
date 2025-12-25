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
            .background(errorAlert)
            .task {
                await viewModel.loadData()
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
                                rating: nft.rating ?? 0,
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
                        .font(Font(UIFont.bodyBold))
                }
            }
        }
    }
    
    private var loadingOverlay: some View {
        ProgressBarView(
            isActive: viewModel.isInitialLoading || viewModel.isLikeUpdating
        )
    }
    
    private var errorAlert: some View {
        EmptyView()
            .alert(
                Constants.errorTitle,
                isPresented: isErrorPresented
            ) {
                Button(Constants.cancel, role: .cancel) {
                    viewModel.state = .loaded
                }
                Button(Constants.retry) {
                    Task {
                        if case .error(let operation) = viewModel.state {
                            await viewModel.retry(operation)
                        }
                    }
                }
            }
    }
    
    private var isErrorPresented: Binding<Bool> {
        Binding(
            get: { viewModel.state.isError },
            set: { newValue in
                if !newValue {
                    viewModel.state = .loaded
                }
            }
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
final class APreviewProfileService: ProfileServiceProtocol {
    func getProfile() async throws -> User {
        User(
            name: "Preview",
            avatarRaw: nil,
            description: nil,
            websiteRaw: "",
            nfts: [],
            likes: [],
            rating: 5,
            id: "preview"
        )
    }
    func updateProfile(_ request: ProfileUpdateRequest) async throws -> User { try await getProfile() }
    func getProfileLikes() async throws -> [String] { ["1", "2"] }
    func addLikeForNft(_ nftId: String) async throws -> [String] { ["1", "2"] }
    func removeLikeFromNft(_ nftId: String) async throws -> [String] { [] }
}
final class PreviewNftService: NftService {
    func loadNft(id: String) async throws -> Nft {
        Nft(
            id: id,
            images: [
                URL(string: "https://picsum.photos/200")!
            ],
            rating: 4,
            price: 12.5,
            name: "Preview NFT \(id)",
            author: "Preview",
            createdAt: nil,
            description: "Preview description"
        )
    }
}
#endif
#if DEBUG
#Preview {
    let viewModel = FavNFTViewModel(
        nftService: PreviewNftService(),
        profileService: APreviewProfileService(),
        nftIds: ["1", "2", "3", "4"]
    )
    return NavigationStack {
        FavNFTView(viewModel: viewModel)
    }
}
#endif
