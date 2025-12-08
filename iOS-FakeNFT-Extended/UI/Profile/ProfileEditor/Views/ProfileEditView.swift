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
    
    // Dialog
    static let photoDialogTitle = "Фото профиля"
    static let changePhoto = "Изменить фото"
    static let deletePhoto = "Удалить фото"
    static let cancel = "Отмена"
    
    // Icons
    static let cameraIcon = "camera.fill"
    static let backIcon = "chevron.left"
}

// MARK: - ProfileEditView
struct ProfileEditView: View {
    
    // MARK: - State
    @State var name: String = ""
    @State var description: String = ""
    @State var website: String = ""
    @State private var isPhotoMenuPresented = false
    @State var photoURL: URL?
    
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
        .confirmationDialog(Text(Constants.photoDialogTitle),
                            isPresented: $isPhotoMenuPresented,
                            titleVisibility: .visible) {
            Button(Constants.changePhoto) {
                // add action
            }
            Button(Constants.deletePhoto, role: .destructive) {
                photoURL = nil
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
            
            AutoGrowingTextEditor(text: $description)
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
    
    // MARK: - Toolbar
    private var navigationToolbar: some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            Button { dismiss() } label: {
                Image(systemName: Constants.backIcon)
                    .font(.system(size: 20, weight: .medium))
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
            description: "Дизайнер из Казани, люблю цифровое искусство и бейглы. В моей коллекции уже 100+ NFT, и еще больше — на моём сайте. Открыт к коллаборациям.",
            website: "JoaquinPhoenix.com",
            photoURL: URL(string: "https://i.pravatar.cc/150")
        )
    }
}
