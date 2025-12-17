//
//  ProfileEditView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Ди Di on 05/12/25.
//

import SwiftUI

struct ProfileEditView: View {
    // MARK: - AppStorage
    @AppStorage(StorageKeys.name) private var storedName: String = ""
    @AppStorage(StorageKeys.description) private var storedDescription: String = ""
    @AppStorage(StorageKeys.website) private var storedWebsite: String = ""
    @AppStorage(StorageKeys.photoURL) private var savedPhotoURL: String = ""
    
    @State private var viewModel = ProfileEditViewModel()
    @Binding var isEditing: Bool
    @Environment(\.dismiss) var dismiss
    
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
            viewModel.onAppear(
                storedName: storedName,
                storedDescription: storedDescription,
                storedWebsite: storedWebsite
            )
        }
        .confirmationDialog(
            Text(Constants.photoDialog),
            isPresented: $viewModel.isPhotoMenuPresented,
            titleVisibility: .visible
        ) {
            Button(Constants.changePhoto) {
                viewModel.photoURLText = savedPhotoURL
                viewModel.showLinkPhotoAlert = true
            }
            
            Button(Constants.deletePhoto, role: .destructive) {
                savedPhotoURL = ""
            }
            
            Button(Constants.cancel, role: .cancel) {}
        }
        .onTapGesture {
            hideKeyboard()
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            navigationToolbar
        }
        .overlay {
            alertOverlaySection
        }
        .overlay {
            ExitAlert(isPresented: $viewModel.showExitAlert) {
                dismiss()
            }
        }
        .overlay(alignment: .bottom) {
            if viewModel.hasChanges(
                storedName: storedName,
                storedDescription: storedDescription,
                storedWebsite: storedWebsite
            ) {
                saveButton
            }
        }
    }
    
    // MARK: - Views
    private var photoSection: some View {
        ZStack(alignment: .bottomTrailing) {
            ProfilePhotoView(
                url: viewModel.photoURL(savedPhotoURL: savedPhotoURL)
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
        ) {
            viewModel.applyPhotoURL(savedPhotoURL: &savedPhotoURL)
        }
    }
    
    private var navigationToolbar: some ToolbarContent {
        Group {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    if viewModel.hasChanges(
                        storedName: storedName,
                        storedDescription: storedDescription,
                        storedWebsite: storedWebsite
                    ) {
                        viewModel.showExitAlert = true
                    } else {
                        dismiss()
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
                viewModel.saveProfile(
                    storedName: &storedName,
                    storedDescription: &storedDescription,
                    storedWebsite: &storedWebsite
                )
                isEditing = false
                dismiss()
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

#Preview {
    NavigationStack {
        ProfileEditView(isEditing: .constant(true))
            .environment(\.locale, .init(identifier: "ru"))
    }
}
