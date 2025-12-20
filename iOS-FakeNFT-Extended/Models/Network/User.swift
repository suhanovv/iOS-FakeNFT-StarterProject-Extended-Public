import Foundation

struct User: Decodable, Identifiable {
    let name: String
    let avatar: URL
    let description: String?
    let website: URL
    let nfts: [String]
    //    @StringToInt
    var rating: Int
    let id: String
}
