//
//  View+HideKeyboard.swift
//  iOS-FakeNFT-Extended
//
//  Created by Ди Di on 08/12/25.
//

import SwiftUI

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(
            #selector(UIResponder.resignFirstResponder),
            to: nil,
            from: nil,
            for: nil
        )
    }
}
