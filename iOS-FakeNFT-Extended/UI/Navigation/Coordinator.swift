//
//  Coordinator.swift
//  iOS-FakeNFT-Extended
//
//  Created by Вадим Суханов on 11.12.2025.
//


import SwiftUI

@Observable
@MainActor
final class Coordinator {
    var path = NavigationPath()
    
    init() {}

    @ViewBuilder
    func build(screen: Screen) -> some View {
        switch screen {
            case .main: ContentView()
            case .usersList: StatisticsScreenView()
            case .userCard(let userId): StatisticsUserCardScreenView(userId: userId)
            case .userCollection(userId: let userId): StatisticsUserCollectionScreenView(userId: userId)
        }
    }
    
    func push(_ screen: Screen) {
        path.append(screen)
    }
    
    func pop() {
        guard !path.isEmpty else { return }
        path.removeLast()
    }
    
    func popToRoot() {
        guard !path.isEmpty else { return }
        path.removeLast(path.count)
    }
}

