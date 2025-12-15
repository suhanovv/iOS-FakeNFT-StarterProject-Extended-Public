//
//  ProgressBarView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Вадим Суханов on 10.12.2025.
//

import SwiftUI

struct ProgressBarView: View {
    let isActive: Bool
    
    var body: some View {
        RoundedRectangle(cornerRadius: 8)
            .frame(width: 82, height: 82)
            .foregroundStyle(.progressBar)
            .overlay {
                ProgressView()
            }
            .opacity(isActive ? 1 : 0)
    }
}

#Preview {
    ProgressBarView(isActive: true)
}
