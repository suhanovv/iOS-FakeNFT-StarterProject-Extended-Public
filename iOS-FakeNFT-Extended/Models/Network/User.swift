import Foundation

struct User: Decodable, Identifiable, Hashable {
    let name: String
    let avatar: URL?
    let description: String?
    let website: URL
    let nfts: [String]
    let likes: [String]
    //    @StringToInt
    let rating: Int?
    let id: String
    
}
