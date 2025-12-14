//
//  ProfileEditView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Ди Di on 05/12/25.
//

import SwiftUI

struct ProfileEditView: View {
    // MARK: - AppStorage
    @AppStorage(Constants.StorageKeys.name) private var storedName: String = ""
    @AppStorage(Constants.StorageKeys.description) private var storedDescription: String = ""
    @AppStorage(Constants.StorageKeys.website) private var storedWebsite: String = ""
    @AppStorage(Constants.StorageKeys.photoURL) private var savedPhotoURL: String = ""
    
    // MARK: - State
    @State private var name: String = ""
    @State private var description: String = ""
    @State private var website: String = ""
    @State private var isPhotoMenuPresented = false
    @State private var showLinkPhotoAlert = false
    @State private var photoURLText = ""
    @State private var showExitAlert = false
    
    @Environment(\.dismiss) var dismiss
    
    private var photoURL: URL? {
        URL(string: savedPhotoURL)
    }
    
    private var hasChanges: Bool {
        name != storedName ||
        description != storedDescription ||
        website != storedWebsite
    }
    
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
            name = storedName
            description = storedDescription
            website = storedWebsite
        }
        .confirmationDialog(
            Text(Constants.Titles.photoDialog),
            isPresented: $isPhotoMenuPresented,
            titleVisibility: .visible
        ) {
            Button(Constants.Buttons.changePhoto) {
                photoURLText = savedPhotoURL
                showLinkPhotoAlert = true
            }
            
            Button(Constants.Buttons.deletePhoto, role: .destructive) {
                savedPhotoURL = ""
            }
            
            Button(Constants.Buttons.cancel, role: .cancel) {}
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
            ExitAlert(isPresented: $showExitAlert) {
                dismiss()
            }
        }
        .overlay(alignment: .bottom) {
            if hasChanges {
                saveButton
            }
        }
    }
    
    // MARK: - Views
    private var photoSection: some View {
        ZStack(alignment: .bottomTrailing) {
            ProfilePhotoView(url: photoURL)
                .offset(y: -4)
                .onTapGesture { isPhotoMenuPresented = true }
            
            Image(systemName: "chevron.left")
                .font(.system(size: 10))
                .padding(6)
                .background(Color.ypLightGray)
                .clipShape(Circle())
        }
    }
    
    private var nameSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(Constants.StorageKeys.profileName)
                .font(Font(UIFont.headline3))
            
            TextField("", text: $name)
                .font(Font(UIFont.bodyRegular))
                .padding()
                .background(Color(.ypLightGray))
                .clipShape(RoundedRectangle(cornerRadius: 12))
        }
        .padding(.horizontal, 16)
    }
    
    private var descriptionSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(Constants.StorageKeys.profileDescription)
                .font(Font(UIFont.headline3))
            
            ProfileAutoGrowingTextEditor(text: $description)
        }
        .padding(.horizontal, 16)
    }
    
    private var websiteSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(Constants.StorageKeys.profileWebsite)
                .font(Font(UIFont.headline3))
            
            TextField("", text: $website)
                .font(Font(UIFont.bodyRegular))
                .padding()
                .background(Color(.ypLightGray))
                .clipShape(RoundedRectangle(cornerRadius: 12))
        }
        .padding(.horizontal, 16)
    }
    
    private var alertOverlaySection: some View {
        TextFieldAlert(
            isPresented: $showLinkPhotoAlert,
            title: Constants.Titles.photoAlert,
            placeholder: Constants.StorageKeys.photoAlertPh,
            text: $photoURLText
        ) {
            let trimmed = photoURLText.trimmingCharacters(in: .whitespacesAndNewlines)
            if URL(string: trimmed) != nil {
                savedPhotoURL = trimmed
            }
        }
    }
    
    // MARK: - Toolbar
    private var navigationToolbar: some ToolbarContent {
        Group {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    if hasChanges {
                        showExitAlert = true
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
                saveProfile()
                dismiss()
            } label: {
                Text("")
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
    
    private func saveProfile() {
        storedName = name
        storedDescription = description
        storedWebsite = website
    }
}

// MARK: - Preview_ProfileEditView
#Preview {
    NavigationStack {
        ProfileEditView()
            .environment(\.locale, .init(identifier: "ru"))
    }
}
