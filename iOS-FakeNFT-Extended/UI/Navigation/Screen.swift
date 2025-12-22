//
//  Screen.swift
//  iOS-FakeNFT-Extended
//
//  Created by Вадим Суханов on 11.12.2025.
//

import Foundation

enum Screen: Hashable {
    case main
    case usersList
    case userCard(userId: String)
    case userCollection(userId: String)
    case webView(url: URL)
    case collection(id: String)
    case catalogue
}
