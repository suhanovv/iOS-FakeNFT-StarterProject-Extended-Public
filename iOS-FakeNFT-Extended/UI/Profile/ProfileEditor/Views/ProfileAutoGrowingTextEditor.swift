//
//  ProfileAutoGrowingTextEditor.swift
//  iOS-FakeNFT-Extended
//
//  Created by Ди Di on 08/12/25.
//

import SwiftUI

struct ProfileAutoGrowingTextEditor: View {
    @Binding var text: String
    @State private var height: CGFloat = 40

    private let font = Font.system(size: 17)
    private let padding: CGFloat = 12
    private let heightCorrection: CGFloat = 8

    var body: some View {
        ZStack(alignment: .topLeading) {

            Text(text.isEmpty ? " " : text)
                .font(font)
                .padding(padding)
                .background(
                    GeometryReader { geo in
                        Color.clear
                            .onAppear {
                                height = geo.size.height + heightCorrection
                            }
                            .onChange(of: geo.size.height) { _, newValue in
                                height = newValue + heightCorrection
                            }
                    }
                )
                .opacity(0)

            TextEditor(text: $text)
                .font(font)
                .padding(padding)
                .frame(height: height)
                .scrollContentBackground(.hidden)
                .background(Color.ypLightGray)
        }
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

// MARK: - Preview_AutoGrowingTextEditor
#Preview {
    VStack(alignment: .leading, spacing: 16) {
        Text("Текст")
            .font(.headline)
        
        ProfileAutoGrowingTextEditor(text: .constant("Пример текста\nкоторый растёт\nпо мере ввода"))
            .padding()
    }
    .padding()
}
