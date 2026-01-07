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
    let services: ServicesAssembly
    
    init(services: ServicesAssembly) {
        self.services = services
    }
    
    @ViewBuilder
    func build(screen: Screen) -> some View {
        switch screen {
        case .main: ContentView()
            
        case .usersList: StatisticsScreenView(viewModel: .init(usersService: services.userService))
            
        case .userCard(let userId):
            StatisticsUserCardScreenView(
                viewModel: .init(userId: userId, usersService: services.userService))
            
        case .userCollection(userId: let userId):
            StatisticsUserCollectionScreenView(
                viewModel: .init(
                    userId: userId,
                    profileService: services.profileService,
                    orderService: services.orderService,
                    usersService: services.userService,
                    nftService: services.nftService)
            )
            
        case .catalogue:
            CatalogueView(
                collectionsService: services.collectionsService
            )
            .environment(services)
            
        case .collection(let id):
            CollectionView(
                collectionId: id,
                collectionService: services.collectionService,
                orderService: services.orderService
            )
            
        case .webView(url: let url):
            WebViewScreen(url: url)

        case .cart:
            CartContainerView()
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

