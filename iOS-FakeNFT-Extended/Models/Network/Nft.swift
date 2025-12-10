import Foundation

struct Nft: Decodable, Identifiable {
    let id: String
    let images: [URL]
    let name: String
    let rating: Int
    let price: Double
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
    
    static func makeRandom() -> Nft {
        .init(
            id: UUID().uuidString,
            images: [
                [
                    URL(string:"https://code.s3.yandex.net/Mobile/iOS/NFT/Gray/Bethany/1.png")!,
                    URL(string:"https://code.s3.yandex.net/Mobile/iOS/NFT/Gray/Piper/1.png")!,
                    URL(string:"https://cs8.pikabu.ru/post_img/2016/07/07/5/146787345912637312.jpg")!
                ].randomElement()!,
            ],
            name: ["Dominique Parks", "Carmine Wooten", "Dominator"].randomElement()!,
            rating: Int.random(in: 1...5),
            price: Double.random(in: 0.01...100)
            )
    }
}
