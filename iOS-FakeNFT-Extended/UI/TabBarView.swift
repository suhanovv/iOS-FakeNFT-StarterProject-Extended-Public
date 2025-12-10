import SwiftUI

struct TabBarView: View {

    init() {
        UITabBar.appearance().unselectedItemTintColor = .ypBlack
    }

    var body: some View {
        TabView {
            NavigationStack {
                CatalogueView()
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

