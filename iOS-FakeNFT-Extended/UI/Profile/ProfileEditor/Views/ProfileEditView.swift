//
//  ProfileEditView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Ди Di on 05/12/25.
//

import SwiftUI

struct ProfileEditView: View {
    let profile: User
    
    @State private var viewModel = ProfileEditViewModel()
    @Environment(Coordinator.self) private var coordinator
    
    // MARK: - Body
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                photoSection
                nameSection
                descriptionSection
                websiteSection
                
                Spacer(minLength: 40)
            }
        }
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
        .navigationBarBackButtonHidden(true)
        .overlay {
            alertOverlaySection
        }
        .overlay {
            ExitAlert(isPresented: $viewModel.showExitAlert) {
                coordinator.pop()
            }
        }
        .overlay(alignment: .bottom) {
            if viewModel.hasChanges(comparedTo: profile) {
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
            ProfilePhotoView(
                url: viewModel.avatarURL
            )
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
                .font(Font(UIFont.headline3))
            
            TextField("", text: $viewModel.name)
                .font(Font(UIFont.bodyRegular))
                .padding()
                .background(Color(.ypLightGray))
                .clipShape(RoundedRectangle(cornerRadius: 12))
        }
        .padding(.horizontal, 16)
    }
    
    private var descriptionSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(Constants.profileDescription)
                .font(Font(UIFont.headline3))
            
            ProfileAutoGrowingTextEditor(text: $viewModel.description)
        }
        .padding(.horizontal, 16)
    }
    
    private var websiteSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(Constants.profileWebsite)
                .font(Font(UIFont.headline3))
            
            TextField("", text: $viewModel.website)
                .font(Font(UIFont.bodyRegular))
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
    
    private var navigationToolbar: some ToolbarContent {
        Group {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    if viewModel.hasChanges(comparedTo: profile) {
                        viewModel.showExitAlert = true
                    } else {
                        coordinator.pop()
                    }
                } label: {
                    Image(systemName: "chevron.left")
                        .font(Font(UIFont.headline5))
                        .foregroundColor(.ypBlack)
                }
            }
        }
    }
    
    private var saveButton: some View {
        VStack {
            Spacer()
            Button {
                Task {
                    try await viewModel.saveProfile()
                    coordinator.pop()
                }
            } label: {
                Text(Constants.save)
                    .font(Font(UIFont.bodyBold))
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
#Preview {
    let coordinator = Coordinator(
        services: ServicesAssembly(
            networkClient: DefaultNetworkClient(),
            nftStorage: NftStorageImpl()
        )
    )

    NavigationStack {
        ProfileEditView(
            profile: User(
                name: "Test",
                avatar: URL(string: "https://picsum.photos/200"),
                description: "Desc",
                website: URL(string: "https://example.com")!,
                nfts: [],
                likes: [],
                rating: 5,
                id: "1"
            )
        )
    }
    .environment(coordinator)
}
