//
//  CartScreenState.swift
//  iOS-FakeNFT-Extended
//
//  Created by Pavel Komarov on 02.01.2026.
//

import Foundation

enum CartScreenState: Equatable {
    case initial
    case loading
    case loaded
    case error(String)
}
