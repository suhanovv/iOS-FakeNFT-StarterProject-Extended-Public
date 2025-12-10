//
//  ProfileEditView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Ди Di on 05/12/25.
//

import SwiftUI

// MARK: - Constants
private enum Constants {
    // Titles
    static let nameTitle = "Имя"
    static let descriptionTitle = "Описание"
    static let websiteTitle = "Сайт"
    static let linkAlertTitle = "Ссылка на фото"
    
    // Dialog
    static let photoDialogTitle = "Фото профиля"
    static let changePhoto = "Изменить фото"
    static let deletePhoto = "Удалить фото"
    static let cancel = "Отмена"
    
    // Icons
    static let cameraIcon = "camera.fill"
    static let backIcon = "chevron.left"
    
    //Placeholder
    static let placeholder = "Введите ссылку"
}

// MARK: - ProfileEditView
struct ProfileEditView: View {
    
    // MARK: - Incoming data
    let initialName: String
    let initialDescription: String
    let initialWebsite: String
    
    // MARK: - State
    @State var name: String = ""
    @State var description: String = ""
    @State var website: String = ""
    @State private var isPhotoMenuPresented = false
    @State private var showLinkPhotoAlert = false
    @State private var photoURLText = ""
    @State private var showExitAlert = false
    
    @AppStorage(ProfileStorageKeys.photoURL) private var savedPhotoURL: String = ""
    @Environment(\.dismiss) var dismiss
    
    init(name: String, description: String, website: String) {
        self.initialName = name
        self.initialDescription = description
        self.initialWebsite = website
        
        _name = State(initialValue: name)
        _description = State(initialValue: description)
        _website = State(initialValue: website)
    }
    
    private var hasChanges: Bool {
        name != initialName ||
        description != initialDescription ||
        website != initialWebsite
    }
    
    private var photoURL: URL? {
        URL(string: savedPhotoURL)
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
        .confirmationDialog(
            Text(Constants.photoDialogTitle),
            isPresented: $isPhotoMenuPresented,
            titleVisibility: .visible
        ) {
            Button(Constants.changePhoto) {
                photoURLText = savedPhotoURL
                showLinkPhotoAlert = true
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
            ExitAlert(isPresented: $showExitAlert) {
                dismiss()
            }
        }
    }
    
    // MARK: - Views
    private var photoSection: some View {
        ZStack(alignment: .bottomTrailing) {
            ProfilePhotoView(url: photoURL)
                .offset(y: -4)
                .onTapGesture { isPhotoMenuPresented = true }
            
            Image(systemName: Constants.cameraIcon)
                .font(.system(size: 10))
                .padding(6)
                .background(Color.ypLightGray)
                .clipShape(Circle())
        }
    }
    
    private var nameSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(Constants.nameTitle)
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
            Text(Constants.descriptionTitle)
                .font(Font(UIFont.headline3))
            
            ProfileAutoGrowingTextEditor(text: $description)
        }
        .padding(.horizontal, 16)
    }
    
    private var websiteSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(Constants.websiteTitle)
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
            title: Constants.linkAlertTitle,
            placeholder: Constants.placeholder,
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

// MARK: - Preview_ProfileEditView
#Preview {
    NavigationStack {
        ProfileEditView(
            name: "Joaquin Phoenix",
            description: "Дизайнер из Казани и т.д...",
            website: "https://example.com"
        )
        .environment(\.colorScheme, .light)
        .onAppear {
            UserDefaults.standard.set(
                "https://i.pravatar.cc/150",
                forKey: ProfileStorageKeys.photoURL
            )
        }
    }
}
