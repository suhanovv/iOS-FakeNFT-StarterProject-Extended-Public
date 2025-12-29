//
//  CollectionDTO.swift
//  iOS-FakeNFT-Extended
//
//  Created by Diana Viter on 09.12.2025.
//

import Foundation

/// DTO-модель коллекции, приходящая из API.
/// Используется для сетевого слоя и декодирования данных о коллекциях.
struct CollectionDTO: Identifiable, Codable, Sendable {

    /// Уникальный идентификатор коллекции (значение приходит из API).
    let id: String

    /// Название коллекции, отображаемое в каталоге.
    let name: String

    /// URL обложки коллекции. Используется для превью на карточке.
    let cover: URL

    /// Описание коллекции, приходящее из API.
    let description: String

    /// Имя автора коллекции (может отсутствовать в ответе API).
    let author: String

    /// Сайт автора или коллекции (опционально, может быть nil).
    let website: URL?

    /// Список идентификаторов NFT, входящих в коллекцию (ключ `nfts` в API).
    let nftIds: [String]

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case cover
        case description
        case author
        case website
        case nftIds = "nfts"
    }
}

extension CollectionDTO {
    var nftCount: Int {
        Set(nftIds.map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .filter { !$0.isEmpty }
        ).count
    }
}
