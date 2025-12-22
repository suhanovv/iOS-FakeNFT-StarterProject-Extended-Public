import Foundation

struct Nft: Identifiable, Decodable {
    let id: String
    let images: [URL]
    let rating: Int?
    let price: Double?
    let name: String?
    let author: String?
    let createdAt: String?
    let description: String?
}


