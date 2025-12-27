//
//  StringFormatter.swift
//  iOS-FakeNFT-Extended
//
//  Created by Diana Viter on 18.12.2025.
//

import Foundation

extension String {
    func sentenceCase() -> String {
        let lowercased = self.lowercased()
        guard let first = lowercased.first else { return self }
        return first.uppercased() + lowercased.dropFirst()
    }
}
