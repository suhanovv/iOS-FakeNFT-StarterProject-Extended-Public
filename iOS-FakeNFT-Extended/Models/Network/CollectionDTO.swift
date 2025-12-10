//
//  CollectionDTO.swift
//  iOS-FakeNFT-Extended
//
//  Created by Diana Viter on 09.12.2025.
//

import Foundation

<<<<<<< HEAD
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
=======
/// DTO-модель коллекции, приходящая из API.
/// Используется для сетевого слоя и декодирования данных о коллекциях.
>>>>>>> 125d0bf (chore: small cleanup across files based on review comments)
struct CollectionDTO: Identifiable, Codable {

    /// Уникальный идентификатор коллекции (значение приходит из API).
    let id: String

    /// Название коллекции, отображаемое в каталоге.
    let name: String

    /// URL обложки коллекции. Используется для превью на карточке.
    let cover: URL

    /// Описание коллекции, приходящее из API.
    let description: String

    /// Идентификатор автора коллекции (ключ `author` в API).
    let authorId: String

    /// Имя автора коллекции (может отсутствовать в ответе API).
    let authorName: String?

    /// Сайт автора или коллекции (опционально, может быть nil).
    let website: URL?
<<<<<<< HEAD
>>>>>>> 427e8ea (feat(catalogue): add catalogue & collection UI, DTOs and navigation)
=======

    /// Список идентификаторов NFT, входящих в коллекцию (ключ `nfts` в API).
>>>>>>> 125d0bf (chore: small cleanup across files based on review comments)
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
