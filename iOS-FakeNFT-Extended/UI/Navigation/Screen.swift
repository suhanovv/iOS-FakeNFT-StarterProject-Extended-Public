import Foundation

enum Screen: Hashable {
    case main
    case profile
    case profileEdit(profile: User)
    case myNft(ids: [String])
    case favouriteNft(ids: [String])
    case usersList
    case userCard(userId: String)
    case userCollection(userId: String)
    case webView(url: URL)
}
