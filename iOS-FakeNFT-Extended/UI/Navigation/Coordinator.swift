import SwiftUI

@Observable
@MainActor
final class Coordinator {
    var path = NavigationPath()
    let services: ServicesAssembly
    
    var isProfileLoading: Bool = false
    var currentProfile: User? = nil
    
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
                profileService: services.profileService
            )
            
        case .profileEdit(let profile):
            ProfileEditView(profile: profile)
            
        case .myNft(let ids):
            MyNFTView(
                viewModel: MyNFTViewModel(
                    nftService: services.nftService,
                    nftIds: ids
                )
            )
            
        case .favouriteNft(let ids):
            FavNFTView(
                viewModel: FavNFTViewModel(
                    nftService: services.nftService,
                    nftIds: ids
                )
            )
            
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

