//
//  MyNFTView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Ди Di on 12/12/25.
//

import SwiftUI

struct MyNFTView: View {
    @AppStorage(AppStorageNftKeys.nftSortBy)
    private var nftSortOrder: NftSortType = .byName
    
    @State private var isNftMenuPresented = false
    @State private var viewModel: MyNFTViewModel
    
    init(viewModel: MyNFTViewModel) {
        _viewModel = State(initialValue: viewModel)
    }
    
    private var sortedNfts: [Nft] {
        viewModel.sortedNFTs(
            from: viewModel.nfts,
            sortType: nftSortOrder
        )
    }
    
    var body: some View {
        ZStack {
            content
            ProgressBarView(
                isActive: viewModel.state == .loading || viewModel.isLikeUpdating
            )
        }
        .navigationBarBackButtonHidden(true)
        .toolbarBackground(.hidden, for: .bottomBar)
        .toolbar { toolbarContent }
        .confirmationDialog(
            Text(Constants.sortNFT),
            isPresented: $isNftMenuPresented,
            titleVisibility: .visible
        ) {
            Button(Constants.sortByPrice) {
                nftSortOrder = .byPrice
            }
            Button(Constants.sortByRating) {
                nftSortOrder = .byRating
            }
            Button(Constants.sortByName) {
                nftSortOrder = .byName
            }
            Button(Constants.close, role: .cancel) {}
        }
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
    
    private var content: some View {
        Group {
            if viewModel.state == .loaded && sortedNfts.isEmpty {
                MyNFTEmptyView()
            } else if !sortedNfts.isEmpty {
                List {
                    ForEach(sortedNfts, id: \.id) { nft in
                        MyNFTCell(
                            nft: nft,
                            rating: nft.rating,
                            isFavourite: viewModel.likedIds.contains(nft.id),
                            onLikeTap: {
                                Task {
                                    await viewModel.toggleLike(nftId: nft.id)
                                }
                            }
                        )
                        .padding(.leading, 16)
                        .padding(.trailing, 39)
                        .padding(.vertical, 16)
                        .listRowInsets(EdgeInsets())
                        .listRowSeparator(.hidden)
                    }
                }
                .listStyle(.plain)
                .navigationBarTitleDisplayMode(.inline)
                .ignoresSafeArea(.container, edges: .bottom)
            }
        }
    }
    
    private var toolbarContent: some ToolbarContent {
        Group {
            if viewModel.state != .empty {
                ToolbarItem(placement: .principal) {
                    Text(Constants.myNFT)
                        .font(.system(size: 17, weight: .bold))
                }
            }
            if !sortedNfts.isEmpty {
                ToolbarItem(placement: .principal) {
                    Text(Constants.myNFT)
                        .font(.system(size: 17, weight: .bold))
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isNftMenuPresented = true
                    } label: {
                        Image(.CommonIcons.sort)
                            .foregroundColor(.ypBlack)
                    }
                }
            }
        }
    }
}

private enum Constants {
    static let myNFT = NSLocalizedString("Profile.myNFT", comment: "")
    static let sortNFT = NSLocalizedString("Profile.sorting.title", comment: "")
    static let sortByPrice = NSLocalizedString("Profile.sorting.byPriceButton", comment: "")
    static let sortByRating = NSLocalizedString("Profile.sorting.byRatingButton", comment: "")
    static let sortByName = NSLocalizedString("Profile.sorting.byNameButton", comment: "")
    static let close = NSLocalizedString("Profile.sorting.closeButton", comment: "")
    static let errorTitle = NSLocalizedString("Profile.error.title", comment: "")
    static let retry  = NSLocalizedString("Profile.retryButton", comment: "")
    static let cancel = NSLocalizedString("Profile.cancelButton", comment: "")
}

// MARK: - Preview_MyNFTView
#if DEBUG
final class PreviewMyNFTProfileService: ProfileServiceProtocol {
    private let profile = Profile(
        name: "Preview",
        avatar: nil,
        description: nil,
        website: nil,
        nfts: ["1", "2"],
        likes: ["1"],
        id: "preview"
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
        profile.likes
    }
    func removeLikeFromNft(_ nftId: String) async throws -> [String] {
        profile.likes.filter { $0 != nftId }
    }
}
#endif
#if DEBUG
final class PreviewMyNFTService: NftService {
    func loadNft(id: String) async throws -> Nft {
        Nft(
            id: id,
            images: [URL(string: "https://picsum.photos/200")!],
            rating: 4,
            price: 10.5,
            name: "My NFT \(id)",
            author: "Preview",
            createdAt: "2024-01-01",
            description: "Preview NFT"
        )
    }
}
#endif
#if DEBUG
#Preview {
    let viewModel = MyNFTViewModel(
        nftService: PreviewMyNFTService(),
        profileService: PreviewMyNFTProfileService(),
        nftIds: ["1", "2"]
    )
    NavigationStack {
        MyNFTView(viewModel: viewModel)
    }
}
#endif
