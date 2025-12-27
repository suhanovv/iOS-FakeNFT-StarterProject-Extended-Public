//
//  NFTScreenState.swift
//  iOS-FakeNFT-Extended
//
//  Created by Ди Di on 20/12/25.
//

enum NFTScreenOperation: Equatable {
    case loadData
    case toggleLike(String)
}

enum NFTScreenState: Equatable {
    case loading
    case loaded
    case empty
    case error(operation: NFTScreenOperation)
    
    var isError: Bool {
        if case .error = self { return true }
        return false
    }
}
