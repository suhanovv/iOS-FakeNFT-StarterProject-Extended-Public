import Foundation

<<<<<<< HEAD
struct Nft: Decodable, Identifiable, Sendable {
=======
struct Nft: Decodable, Identifiable {
>>>>>>> 360b056 (Statistics/epic branch (#118))
    let id: String
    let name: String
    let images: [URL]
<<<<<<< HEAD
    let name: String
    let rating: Int
    let price: Double
<<<<<<< HEAD
}

extension Nft {
    static let sampleDominique: Nft = .init(
        id: "77c9aa30-f07a-4bed-886b-dd41051fade2",
        images: [
            URL(string:"https://code.s3.yandex.net/Mobile/iOS/NFT/Gray/Bethany/1.png")!,
            URL(string:"https://code.s3.yandex.net/Mobile/iOS/NFT/Gray/Bethany/2.png")!,
            URL(string:"https://code.s3.yandex.net/Mobile/iOS/NFT/Gray/Bethany/3.png")!],
        name: "Dominique Parks",
        rating: 2,
        price: 49.99
    )
    
    static let sampleCarmine: Nft = .init(
        id: "1fda6f0c-a615-4a1a-aa9c-a1cbd7cc76ae",
        images: [
            URL(string:"https://code.s3.yandex.net/Mobile/iOS/NFT/Gray/Piper/1.png")!,
            URL(string:"https://code.s3.yandex.net/Mobile/iOS/NFT/Gray/Piper/2.png")!,
            URL(string:"https://code.s3.yandex.net/Mobile/iOS/NFT/Gray/Piper/3.png")!],
        name: "Carmine Wooten",
        rating: 4,
        price: 32.89
    )
=======
>>>>>>> 360b056 (Statistics/epic branch (#118))
=======
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
>>>>>>> d2b1764 (feat(catalogue): add catalogue & collection UI, DTOs and navigation)
}
