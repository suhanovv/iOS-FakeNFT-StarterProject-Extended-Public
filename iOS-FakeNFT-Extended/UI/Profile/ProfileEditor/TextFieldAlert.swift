//
//  TextFieldAlert.swift
//  iOS-FakeNFT-Extended
//
//  Created by Ди Di on 09/12/25.
//

import SwiftUI

// MARK: - Constants
private enum Constants {
    static let cancel = "Отмена"
    static let save = "Сохранить"
}

struct TextFieldAlert: View {
    @Binding var isPresented: Bool
    var title: String
    var placeholder: String = ""
    @Binding var text: String
    var onSave: () -> Void

    var body: some View {
        if isPresented {
            ZStack {
                Color.black.opacity(0.5)
                    .ignoresSafeArea()
                    .onTapGesture { isPresented = false }
                alertBox
            }
            .transition(.opacity)
            .animation(.easeInOut, value: isPresented)
        }
    }
    
    // MARK: - Views
    private var alertBox: some View {
           VStack(spacing: 0) {
               titleSection
               textFieldSection
               Divider().padding(.top, 16)
               buttonsSection
           }
           .frame(width: 273)
           .background(Color(.ypLightGray))
           .cornerRadius(13)
           .shadow(radius: 22)
       }
    
    private var titleSection: some View {
        Text(title)
            .font(Font(UIFont.headline5))
            .foregroundColor(.ypBlack)
            .padding(.top, 16)
            .padding(.bottom, 7)
    }
    
    private var textFieldSection: some View {
        TextField(placeholder, text: $text)
            .padding(12)
            .background(Color(.ypWhite))
            .cornerRadius(11)
            .padding(.horizontal, 16)
    }
    
    private var buttonsSection: some View {
        HStack(spacing: 0) {
            cancelButton
            Divider()
            saveButton
        }
        .frame(height: 44)
    }

    private var cancelButton: some View {
        Button {
            isPresented = false
        } label: {
            Text(Constants.cancel)
                .font(Font(UIFont.bodyRegular))
                .foregroundColor(.ypBlueUniversal)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 11)
        }
    }

    private var saveButton: some View {
        Button {
            isPresented = false
            onSave()
        } label: {
            Text(Constants.save)
                .font(Font(UIFont.bodyBold))
                .foregroundColor(.ypBlueUniversal)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 11)
        }
    }
}

// MARK: - Preview_TextFieldAlert
#Preview {
    TextFieldAlert(
        isPresented: .constant(true),
        title: "Ссылка на фото",
        placeholder: "Введите ссылку",
        text: .constant("http://example.com"),
        onSave: {}
    )
        .ignoresSafeArea()
        .background(Color.ypWhite)
}
