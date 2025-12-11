//
//  NavigationView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Вадим Суханов on 11.12.2025.
//

import SwiftUI

struct NavigationView: View {
    @State private var coordinator = Coordinator()
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            coordinator.build(screen: .main)
                .navigationDestination(for: Screen.self) { screen in
                    coordinator.build(screen: screen)
                        .navigationBarBackButtonHidden(true)
                        .toolbar {
                            ToolbarItem(placement: .topBarLeading) {
                                Image(systemName: "chevron.backward")
                                    .fontWeight(.bold)
                                    .foregroundStyle(.ypBlack)
                                    .onTapGesture {
                                        coordinator.pop()
                                    }
                            }
                        }
                }
        }
        .environment(coordinator)
    }
}

#Preview {
    NavigationView()
}
