import SwiftUI

struct TabBarView: View {
    
    @Environment(ServicesAssembly.self) private var services

    init() {
        UITabBar.appearance().unselectedItemTintColor = .ypBlack
    }

    var body: some View {
        TabView {
            NavigationStack {
                CatalogueView(collectionsService: services.collectionsService)
            }
            .tabItem {
                Label(NSLocalizedString("Tab.catalog", comment: ""),
                      image: .TabBarIcons.cart)
            }

            IconsView()
                .tabItem {
                    Label(NSLocalizedString("Tab.statistics", comment: ""),
                          image: .TabBarIcons.statistics)
                }
        }
    }
}

