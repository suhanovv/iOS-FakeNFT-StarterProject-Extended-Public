//
//  StringToInt.swift
//  iOS-FakeNFT-Extended
//
//  Created by Вадим Суханов on 12.12.2025.
//

import Foundation

@propertyWrapper
struct StringToInt: Decodable {
    let wrappedValue: Int
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let intValue = try? container.decode(Int.self) {
            self.wrappedValue = intValue
            return
        }
        if let stringValue = try? container.decode(String.self),
           let intValue = Int(stringValue) {
            self.wrappedValue = intValue
            return
        }
        throw DecodingError.dataCorruptedError(
            in: container,
            debugDescription: "Expected Int or String convertible to Int"
        )
    }
    
    init (wrappedValue: Int) {
        self.wrappedValue = wrappedValue
    }
}
