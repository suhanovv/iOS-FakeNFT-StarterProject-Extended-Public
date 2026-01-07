import Foundation

enum Screen: Hashable {
    case main
    case catalogue
    case usersList
    case profile

    case profileEdit(Profile)
    case myNft(ids: [String])
    case favouriteNft(ids: [String])

    case userCard(userId: String)
    case userCollection(userId: String)

    case collection(id: String)
    case cart
    case webView(url: URL)
}
