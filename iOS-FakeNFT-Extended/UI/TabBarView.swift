import SwiftUI

struct TabBarView: View {
    init() {
        UITabBar.appearance().unselectedItemTintColor = .ypBlack
    }
    var body: some View {
        TabView {
            TestCatalogView()
                .tabItem {
                    Label(NSLocalizedString("Tab.catalog", comment: ""), image: .TabBarIcons.cart)
                }
                .backgroundStyle(.background)
            IconsView()
                .tabItem {
                    Label(NSLocalizedString("Tab.statistics", comment: ""), image: .TabBarIcons.statistics)
                }
                .backgroundStyle(.background)
        }
    }
}
