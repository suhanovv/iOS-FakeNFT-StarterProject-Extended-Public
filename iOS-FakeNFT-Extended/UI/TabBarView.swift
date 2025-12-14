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
                Label(Constants.Titles.profile, image: .TabBarIcons.profile)
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
