//
//  ProfileAutoGrowingTextEditor.swift
//  iOS-FakeNFT-Extended
//
//  Created by Ди Di on 08/12/25.
//

import SwiftUI

struct ProfileAutoGrowingTextEditor: View {
    @Binding var text: String
    @State private var height: CGFloat = 100
    
    // MARK: - Body
    var body: some View {
        ZStack(alignment: .topLeading) {
            Text(text.isEmpty ? " " : text)
                .font(.system(size: 17, weight: .regular))
                .padding(11)
                .background(
                    GeometryReader { geo in
                        Color.clear.onAppear {
                            height = geo.size.height
                        }
                        .onChange(of: geo.size.height) { oldValue, newValue in
                            height = newValue
                        }
                    }
                )
                .opacity(0)
            
            TextEditor(text: $text)
                .font(.system(size: 17, weight: .regular))
                .padding(.horizontal, 16)
                .frame(height: height)
                .scrollContentBackground(.hidden)
                .background(Color(.ypLightGray))
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
