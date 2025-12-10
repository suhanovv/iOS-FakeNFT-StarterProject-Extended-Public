import Foundation

import Foundation

/// DTO-модель NFT, приходящая из API.
/// Используется для сетевого слоя и отображения данных в каталоге и деталях NFT.
struct Nft: Decodable, Identifiable {

    /// Уникальный идентификатор NFT (значение приходит из API).
    let id: String

    /// Название NFT — отображается на карточках и экране деталей.
    let name: String

    /// Список URL изображений NFT. Может содержать несколько вариантов.
    let images: [URL]

    /// Рейтинг NFT, приходит из API (целочисленное значение).
    let rating: Int

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
}
