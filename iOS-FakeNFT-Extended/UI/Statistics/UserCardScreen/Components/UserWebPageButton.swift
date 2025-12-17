//
//  UserWebPageButton.swift
//  iOS-FakeNFT-Extended
//
//  Created by Вадим Суханов on 09.12.2025.
//
import SwiftUI

struct UserWebPageButton: View {
    let url: URL
    let action: () -> Void
    var body: some View {
        Button(action: action){
            Text(Constants.webpageLinkTitle)
                .font(Font.system(size: 15, weight: .regular))
                .foregroundColor(.ypBlack)
                .frame(height: 40)
        }
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(
                cornerRadius: 16
            )
            .stroke(.ypBlack, lineWidth: 1)
        )
    }
    
    enum Constants {
        static let webpageLinkTitle = NSLocalizedString("UserProfile.webpageLink.title", comment: "")
    }
}
