import Foundation

struct Profile: Decodable, Hashable {
    let name: String
    let avatar: URL
    let description: String
    let website: URL
    let nfts: [String]
    let likes: [String]
    let id: String
}
