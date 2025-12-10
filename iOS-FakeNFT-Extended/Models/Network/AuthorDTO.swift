//
//  AuthorDTO.swift
//  iOS-FakeNFT-Extended
//
//  Created by Diana Viter on 09.12.2025.
//

import Foundation

/// DTO-модель автора, приходящая из API.
/// Используется только для сетевого слоя и декодирования ответа.
struct AuthorDTO: Decodable, Identifiable {
    /// Уникальный идентификатор автора (значение приходит из API).
    let id: String
    /// Имя автора. Используется для отображения в списках и карточках.
    let name: String
    /// Официальный сайт автора. Может отсутствовать в ответе API.
    let website: URL?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case website
    }
}
