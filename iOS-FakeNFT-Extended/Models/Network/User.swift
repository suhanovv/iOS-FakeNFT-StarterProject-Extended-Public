import Foundation

struct User: Decodable, Identifiable {
    let name: String
    let avatar: URL
    let description: String
    let website: URL
    let nfts: [String]
    let rating: Int
    let id: String
}

extension User {
    static func makeFakeUser() -> User {
        
        let avatars = [
            "https://n1s2.hsmedia.ru/10/07/5b/10075bc9f87787e109c8bd9d93e8d66b/600x400_0x0a330c9a_8308133731545062329.jpeg",
            "https://letsenhance.io/static/8f5e523ee6b2479e26ecc91b9c25261e/1015f/MainAfter.jpg",
            "https://i.pinimg.com/736x/07/41/63/0741631fc2493022c067e3a38528a5c2.jpg"
        ]
        return User(
            name: ["Joaquin Phoenix", "Bill", "Elon Musk", "Kanye West"].randomElement()!,
            avatar: URL(string: avatars.randomElement()!)!,
            description: "With a keen eye for emerging trends and a commitment to authenticity, I offer a diverse collection of digital assets that cater to collectors and investors alike.",
            website: URL(string: "https://practicum.yandex.ru/graphic-designer/")!,
            nfts: [],
            rating: Int.random(in: 1...50),
            id: UUID().uuidString)
    }
}
