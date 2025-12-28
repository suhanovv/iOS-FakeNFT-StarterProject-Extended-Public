import SwiftUI

struct ContentView: View {
    @Environment(Coordinator.self) private var coordinator
    
    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        
        appearance.stackedLayoutAppearance.normal.iconColor = .ypBlack
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor(resource: .ypBlack)]
        appearance.stackedLayoutAppearance.selected.iconColor = .ypBlueUniversal
        
        UITabBar.appearance().standardAppearance = appearance
    }
    
    var body: some View {
        TabView {
            coordinator.build(screen: .profile)
                .tabItem {
                    Label(Constants.tabProfileTitle, image: .TabBarIcons.profile)
                }
                .backgroundStyle(.ypWhite)
            
            coordinator.build(screen: .catalogue)
                .tabItem {
                    Label(Constants.tabCatalogTitle, image: .TabBarIcons.cart)
                }
                .backgroundStyle(.ypWhite)
            
            coordinator.build(screen: .usersList)
                .tabItem {
                    Label(Constants.tabStatisticsTitle, image: .TabBarIcons.statistics)
                }
                .backgroundStyle(.ypWhite)
        }
    }
}

private enum Constants {
    static let tabProfileTitle = NSLocalizedString("Tab.profile", comment: "")
    static let tabCatalogTitle = NSLocalizedString("Tab.catalog", comment: "")
    static let tabStatisticsTitle = NSLocalizedString("Tab.statistics", comment: "")
}
