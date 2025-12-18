import SwiftUI

struct TabBarView: View {
    init() {
        UITabBar.appearance().unselectedItemTintColor = .ypBlack
    }
    var body: some View {
        TabView {
            NavigationStack {
                ProfileViewMock.preview
                // Изменить на ProfileView() после подключения запросов
            }
            .tabItem {
                Label(Constants.profile, image: .TabBarIcons.profile)
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

private enum Constants {
    static let profile = NSLocalizedString("Tab.profile", comment: "")
}
