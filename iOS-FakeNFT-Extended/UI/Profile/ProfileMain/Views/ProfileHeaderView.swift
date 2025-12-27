//
//  ProfileHeaderView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Ди Di on 27/12/25.
//

import SwiftUI

struct ProfileHeaderView: View {
    let profile: Profile

    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            ProfilePhotoView(url: profile.avatar)

            Text(profile.name)
                .font(.system(size: 22, weight: .bold))
                .foregroundColor(.ypBlack)

            Spacer()
        }
        .padding(.vertical, 12)
    }
}
