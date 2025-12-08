import Foundation

struct Nft: Decodable, Identifiable {
    let id: String
    let name: String
    let images: [URL]
    let rating: Int
    let price: Decimal
    let author: String
    let website: URL?
    let description: String
    let createdAt: String

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case images
        case rating
        case price
        case author
        case website
        case description
        case createdAt
    }
}


