//
//  Currency.swift
//  iOS-FakeNFT-Extended
//
//  Created by Pavel Komarov on 18.12.2025.
//

import Foundation

/// DTO-модель валюты, получаемая из сетевого ответа
struct Currency: Decodable {
    /// Уникальный идентификатор валюты
    let id: String
    /// Отображаемое название валюты (например: "Доллар США")
    let title: String
    /// Короткое или системное имя валюты (например: "USD")
    let name: String
    /// URL изображения (иконка / флаг валюты)
    let image: URL
}
