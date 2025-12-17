//
//  OperationType.swift
//  iOS-FakeNFT-Extended
//
//  Created by Вадим Суханов on 17.12.2025.
//

extension StatisticsScreenView {
    enum OperationType: Equatable {
        case loadFirstPage(UsersSortType)
        case loadNextPage(UsersSortType)
        case changeSortOrder(UsersSortType)
    }
}
