//
//  ScreenState.swift
//  iOS-FakeNFT-Extended
//
//  Created by Вадим Суханов on 17.12.2025.
//

extension StatisticsUserCollectionScreenView {
    enum ScreenState: Equatable {
        case loading
        case loaded
        case error(operation: OperationType)
        
        var isError: Bool {
            guard case .error = self else { return false }
            return true
        }
    }
}
