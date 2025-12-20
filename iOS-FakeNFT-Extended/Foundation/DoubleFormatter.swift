//
//  DoubleFormatter.swift
//  iOS-FakeNFT-Extended
//
//  Created by Diana Viter on 18.12.2025.
//

import Foundation

extension Double {
    func formattedPrice(maxFractionDigits: Int = 2) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = maxFractionDigits
        return formatter.string(from: NSNumber(value: self)) ?? "\(self)"
    }
}
