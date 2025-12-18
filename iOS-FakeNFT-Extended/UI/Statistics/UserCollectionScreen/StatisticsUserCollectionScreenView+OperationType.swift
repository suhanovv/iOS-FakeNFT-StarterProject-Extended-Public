//
//  OperationType.swift
//  iOS-FakeNFT-Extended
//
//  Created by Вадим Суханов on 17.12.2025.
//

extension StatisticsUserCollectionScreenView {
    enum OperationType: Equatable {
        case toggleLike(String)
        case toggleCart(String)
        case loadData
    }
}
