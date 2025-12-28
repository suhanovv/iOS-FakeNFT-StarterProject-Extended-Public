//
//  ProfileEditView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Ди Di on 05/12/25.
//

import SwiftUI

struct ProfileEditView: View {
    let profile: Profile
    
    @State private var viewModel: ProfileEditViewModel
    @Environment(Coordinator.self) private var coordinator
    
    init(profile: Profile, profileService: ProfileServiceProtocol) {
        self.profile = profile
        _viewModel = State(initialValue: ProfileEditViewModel(profile: profile, profileService: profileService))
    }
    
    // MARK: - Body
    var body: some View {
        ZStack(alignment: .topLeading) {
            
            ScrollView {
                VStack(spacing: 24) {
                    photoSection
                    nameSection
                    descriptionSection
                    websiteSection
                    
                    Spacer(minLength: 40)
                }
                .padding(.top, 44)
            }
            customBackButton
        }
        .toolbar(.hidden, for: .navigationBar)
        .onAppear {
            viewModel.onAppear(profile: profile)
        }
        .confirmationDialog(
            Text(Constants.photoDialog),
            isPresented: $viewModel.isPhotoMenuPresented,
            titleVisibility: .visible
        ) {
            Button(Constants.changePhoto) {
                viewModel.showLinkPhotoAlert = true
            }
            
            Button(Constants.deletePhoto, role: .destructive) {
                viewModel.photoURLText = ""
            }
            Button(Constants.cancel, role: .cancel) {}
        }
        .onTapGesture {
            hideKeyboard()
        }
        .overlay {
            alertOverlaySection
        }
        .overlay {
                   ExitAlert(isPresented: $viewModel.showExitConfirmation) {
                       coordinator.pop()
                   }
               }
        .overlay(alignment: .bottom) {
            if viewModel.hasChanges() {
                saveButton
            }
        }
        .overlay {
            ProgressBarView(isActive: viewModel.isSaving)
        }
    }
    
    // MARK: - Views
    private var photoSection: some View {
        ZStack(alignment: .bottomTrailing) {
            ProfilePhotoView(url: viewModel.avatarURL)
                .offset(y: -4)
                .onTapGesture {
                    viewModel.isPhotoMenuPresented = true
                }
            
            Image(systemName: "camera.fill")
                .font(.system(size: 10))
                .padding(6)
                .background(Color.ypLightGray)
                .clipShape(Circle())
        }
    }
    
    private var nameSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(Constants.profileName)
                .font(.system(size: 22, weight: .bold))
            
            TextField("", text: $viewModel.name)
                .font(.system(size: 17, weight: .regular))
                .padding()
                .background(Color(.ypLightGray))
                .clipShape(RoundedRectangle(cornerRadius: 12))
        }
        .padding(.horizontal, 16)
    }
    
    private var descriptionSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(Constants.profileDescription)
                .font(.system(size: 22, weight: .bold))
            
            ProfileAutoGrowingTextEditor(text: $viewModel.description)
        }
        .padding(.horizontal, 16)
    }
    
    private var websiteSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(Constants.profileWebsite)
                .font(.system(size: 22, weight: .bold))
            
            TextField("", text: $viewModel.website)
                .font(.system(size: 17, weight: .regular))
                .padding()
                .background(Color(.ypLightGray))
                .clipShape(RoundedRectangle(cornerRadius: 12))
        }
        .padding(.horizontal, 16)
    }
    
    private var alertOverlaySection: some View {
        TextFieldAlert(
            isPresented: $viewModel.showLinkPhotoAlert,
            title: Constants.photoAlert,
            placeholder: Constants.photoAlertPh,
            text: $viewModel.photoURLText
        ) {}
    }
    
    private var customBackButton: some View {
           Button {
               if viewModel.hasChanges() {
                   viewModel.showExitConfirmation = true
               } else {
                   coordinator.pop()
               }
           } label: {
               Image(systemName: "chevron.left")
                   .font(.system(size: 17, weight: .semibold))
                   .foregroundColor(.ypBlack)
                   .frame(width: 44, height: 44)
                   .contentShape(Rectangle())
           }
           .padding(.leading, 16)
           .padding(.top, 8)
           .zIndex(10)
       }
    
    private var saveButton: some View {
        VStack {
            Spacer()
            Button {
                    Task {
                        _ = try? await viewModel.saveProfile()
                        coordinator.pop()
                    }
            } label: {
                Text(Constants.save)
                    .font(.system(size: 17, weight: .bold))
                    .foregroundColor(.ypWhite)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.ypBlack)
                    .cornerRadius(16)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 50)
            }
        }
        .ignoresSafeArea(edges: .bottom)
    }
}

private enum Constants {
    static let photoDialog = NSLocalizedString("Profile.photoDialog.title", comment: "")
    static let changePhoto = NSLocalizedString("Profile.photoDialog.changePhoto", comment: "")
    static let deletePhoto = NSLocalizedString("Profile.photoDialog.deletePhoto", comment: "")
    static let cancel = NSLocalizedString("Profile.cancelButton", comment: "")
    static let profileName = NSLocalizedString("Profile.name", comment: "")
    static let profileDescription = NSLocalizedString("Profile.description", comment: "")
    static let profileWebsite = NSLocalizedString("Profile.website", comment: "")
    static let photoAlert = NSLocalizedString("Profile.photoAlert.title", comment: "")
    static let photoAlertPh = NSLocalizedString("Profile.photoAlert.placeholder", comment: "")
    static let save = NSLocalizedString("Profile.saveButton", comment: "")
}

// MARK: - Preview_ProfileEditView
final class PreviewProfileService: ProfileServiceProtocol {
    private let profile: Profile
    init(profile: Profile) {
        self.profile = profile
    }
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
        profile.likes
    }
}
//#Preview {
//    let mockProfile = Profile(
//        name: "Alex Designer",
//        avatar: URL(string: "https://picsum.photos/200")!,
//        description: "iOS developer & NFT enjoyer",
//        website: URL(string: "https://example.com")!,
//        nfts: [],
//        likes: [],
//        id: "1"
//    )
//    let coordinator = Coordinator(
//        services: ServicesAssembly(
//            networkClient: DefaultNetworkClient(),
//            nftStorage: NftStorageImpl()
//        )
//    )
//    NavigationStack {
//        ProfileEditView(
//            profile: mockProfile,
//            profileService: PreviewProfileService(profile: mockProfile)
//        )
//    }
//    .environment(coordinator)
//}
