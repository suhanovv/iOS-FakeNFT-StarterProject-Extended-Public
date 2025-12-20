import Foundation

enum Screen: Hashable {
    case main
    case profile
    case profileEdit
    case myNft
    case favouriteNft
    case usersList
    case userCard(userId: String)
    case userCollection(userId: String)
    case webView(url: URL)
}
