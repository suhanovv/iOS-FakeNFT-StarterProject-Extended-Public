//
//  NavigationView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Вадим Суханов on 11.12.2025.
//

import SwiftUI

struct NavigationView: View {
    @State private var coordinator = Coordinator(
        services: ServicesAssembly(
            networkClient: DefaultNetworkClient(),
            nftStorage: NftStorageImpl()
        )
    )
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            root
                .navigationDestination(for: Screen.self, destination: destination)
        }
        .environment(coordinator)
    }
    
    private var root: some View {
        coordinator.build(screen: .main)
    }
    
    @ViewBuilder
    private func destination(_ screen: Screen) -> some View {
        coordinator.build(screen: screen)
            .navigationBarBackButtonHidden(true)
            .toolbar { backToolbar }
    }
    
    private var backToolbar: some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            backButton
        }
    }
    
    private var backButton: some View {
        Image(systemName: "chevron.backward")
            .fontWeight(.bold)
            .foregroundStyle(.ypBlack)
            .onTapGesture { coordinator.pop() }
    }
}

#Preview {
    NavigationView()
}
