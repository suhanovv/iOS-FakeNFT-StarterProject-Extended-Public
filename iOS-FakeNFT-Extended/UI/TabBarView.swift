import SwiftUI

struct TabBarView: View {
    
    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()

        appearance.stackedLayoutAppearance.normal.iconColor = .ypBlack
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor(resource: .ypBlack)]
        appearance.stackedLayoutAppearance.selected.iconColor = .ypBlueUniversal

        UITabBar.appearance().standardAppearance = appearance
            
    }
    
    var body: some View {
        NavigationStack {
            TabView {
                TestCatalogView()
                    .tabItem {
                        Label(Constants.tabCatalogTitle, image: .TabBarIcons.cart)
                    }
                    .backgroundStyle(.ypWhite)
                StatisticsScreenView()
                    .tabItem {
                        Label(Constants.tabStatisticsTitle, image: .TabBarIcons.statistics)
                    }
                    .background(.ypWhite)
            }
        }
    }
}

private enum Constants {
    static let tabCatalogTitle = NSLocalizedString("Tab.catalog", comment: "")
    static let tabStatisticsTitle = NSLocalizedString("Tab.statistics", comment: "")
}
