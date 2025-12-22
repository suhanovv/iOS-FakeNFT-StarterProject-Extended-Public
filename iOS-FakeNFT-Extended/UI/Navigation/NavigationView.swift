import SwiftUI

struct NavigationView: View {
    @State private var coordinator = Coordinator(
        services: ServicesAssembly(
            networkClient: DefaultNetworkClient(),
            nftStorage: NftStorageImpl()
        )
    )
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            root
                .navigationDestination(for: Screen.self) { screen in
                    coordinator.build(screen: screen)
                        .navigationBarBackButtonHidden(true)
                        .toolbar {
                            if !coordinator.path.isEmpty {
                                ToolbarItem(placement: .navigationBarLeading) {
                                    backButton
                                }
                            }
                        }
                }
                .toolbar {
                    if coordinator.isOnProfileScreen,
                       !coordinator.isProfileLoading,
                       let profile = coordinator.currentProfile {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button {
                                coordinator.push(.profileEdit(profile: profile))
                            } label: {
                                Image(systemName: "square.and.pencil")
                                    .font(.system(size: 24, weight: .semibold))
                                    .foregroundColor(.ypBlack)
                            }
                        }
                    }
                }
        }
        .environment(coordinator)
    }
    
    private var root: some View {
        coordinator.build(screen: .main)
    }
    
    @ViewBuilder
    private func destination(_ screen: Screen) -> some View {
        coordinator.build(screen: screen)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                if screen != .profile {
                    backToolbar
                }
            }
    }
    
    private var backToolbar: some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            backButton
        }
    }
    
    private var backButton: some View {
        Image(systemName: "chevron.backward")
            .fontWeight(.bold)
            .foregroundStyle(.ypBlack)
            .onTapGesture { coordinator.pop() }
    }
}

// MARK: - Preview_NavigationView
#Preview {
    NavigationView()
}
