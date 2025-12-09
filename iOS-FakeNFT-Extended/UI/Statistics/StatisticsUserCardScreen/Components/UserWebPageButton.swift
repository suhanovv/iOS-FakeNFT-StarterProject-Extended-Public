//
//  UserWebPageButton.swift
//  iOS-FakeNFT-Extended
//
//  Created by Вадим Суханов on 09.12.2025.
//
import SwiftUI

struct UserWebPageButton: View {
    var body: some View {
        Button(action: {}){
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
}

private enum Constants {
    static let webpageLinkTitle = NSLocalizedString("UserProfile.webpageLink.title", comment: "")
    
}

#Preview {
    UserWebPageButton()
}
