//
//  CollectionDTO.swift
//  iOS-FakeNFT-Extended
//
//  Created by Diana Viter on 09.12.2025.
//

import Foundation

<<<<<<< HEAD
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
=======
struct CollectionDTO: Identifiable, Codable {
    let id: String
    let name: String
    let cover: URL
    let description: String
    let authorId: String
    let authorName: String?
    let website: URL?
>>>>>>> 427e8ea (feat(catalogue): add catalogue & collection UI, DTOs and navigation)
    let nftIds: [String]

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case cover
        case description
<<<<<<< HEAD
        case author
=======
        case authorId = "author"
        case authorName
>>>>>>> 427e8ea (feat(catalogue): add catalogue & collection UI, DTOs and navigation)
        case website
        case nftIds = "nfts"
    }
}
<<<<<<< HEAD

extension CollectionDTO {
    var nftCount: Int {
        Set(nftIds.map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .filter { !$0.isEmpty }
        ).count
    }
}
=======
>>>>>>> 427e8ea (feat(catalogue): add catalogue & collection UI, DTOs and navigation)
