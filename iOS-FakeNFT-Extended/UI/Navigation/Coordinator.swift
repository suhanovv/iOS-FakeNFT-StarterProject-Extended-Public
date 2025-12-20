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
            
        case .usersList,
                .userCard,
                .userCollection:
            Color.clear
            
        case .profile:
            ProfileView(
                //                viewModel: .init(profileService: services.profileService)
            )
        case .profileEdit:
            ProfileEditView()
            
        case .myNft:
            MyNFTView(nfts: ProfileViewMock.mockNFTs)
            
        case .favouriteNft:
            FavNFTView(allNFTs: ProfileViewMock.mockNFTs)
            
            
            
        case .webView(url: let url): WebView(url: url)
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

