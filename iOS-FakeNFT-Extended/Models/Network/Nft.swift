import Foundation

<<<<<<< HEAD
<<<<<<< HEAD
struct Nft: Decodable, Identifiable, Sendable {
=======
struct Nft: Decodable, Identifiable {
>>>>>>> 360b056 (Statistics/epic branch (#118))
=======
import Foundation

/// DTO-модель NFT, приходящая из API.
/// Используется для сетевого слоя и отображения данных в каталоге и деталях NFT.
struct Nft: Decodable, Identifiable {

    /// Уникальный идентификатор NFT (значение приходит из API).
>>>>>>> 125d0bf (chore: small cleanup across files based on review comments)
    let id: String
    let images: [URL]
<<<<<<< HEAD
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
=======

    /// Рейтинг NFT, приходит из API (целочисленное значение).
>>>>>>> 125d0bf (chore: small cleanup across files based on review comments)
    let rating: Int
<<<<<<< HEAD

    /// Цена NFT. Decimal используется для точных финансовых операций.
    let price: Decimal

    /// Имя автора NFT (string, приходит напрямую из API).
    let author: String

    /// Веб-сайт автора или проекта. Может отсутствовать.
    let website: URL?

    /// Описание NFT. Может быть длинным — приходит в текстовом виде.
    let description: String

    /// Дата создания NFT в текстовом формате (например ISO-8601).
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
=======
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
>>>>>>> 279ca2f (feat: add ViewModels for Catalogue and Collection, add sorting logic for Catalogue and saving sorting results)
}
