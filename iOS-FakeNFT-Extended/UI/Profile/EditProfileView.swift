//
//  EditProfileView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Ди Di on 05/12/25.
//

import SwiftUI

struct EditProfileView: View {
    @State var name: String = ""
    @State var description: String = ""
    @State var website: String = ""
    var photoURL: URL?
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Имя")
                        .font(Font(UIFont.headline3))
                    
                    TextField("", text: $name)
                        .font(Font(UIFont.bodyRegular))
                        .padding()
                        .background(Color(.ypLightGray))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                .padding(.horizontal, 16)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Описание")
                        .font(Font(UIFont.headline3))
                    
                    AutoGrowingTextEditor(text: $description)
                }
                .padding(.horizontal, 16)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Сайт")
                        .font(Font(UIFont.headline3))
                    
                    TextField("", text: $website)
                        .font(Font(UIFont.bodyRegular))
                        .padding()
                        .background(Color(.ypLightGray))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                .padding(.horizontal, 16)
                
                Spacer(minLength: 40)
            }
        }
        .navigationBarBackButtonHidden(false)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                EmptyView()
            }
        }
    }
}

struct AutoGrowingTextEditor: View {
    @Binding var text: String
    @State private var height: CGFloat = 100
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Text(text.isEmpty ? " " : text)
                .font(Font(UIFont.bodyRegular))
                .padding(11)
                .background(
                    GeometryReader { geo in
                        Color.clear.onAppear {
                            height = geo.size.height
                        }.onChange(of: geo.size.height) { oldValue, newValue in
                            height = newValue
                        }
                    }
                )
                .opacity(0)
            
            TextEditor(text: $text)
                .font(Font(UIFont.bodyRegular))
                .padding(.horizontal, 16)
                .frame(height: height)
                .scrollContentBackground(.hidden)
                .background(Color(.ypLightGray))
        }
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
    NavigationStack {
        EditProfileView(
            name: "Joaquin Phoenix",
            description: "Дизайнер из Казани, люблю цифровое искусство и бейглы. В моей коллекции уже 100+ NFT, и еще больше — на моём сайте. Открыт к коллаборациям.",
            website: "JoaquinPhoenix.com",
            photoURL: URL(string: "https://i.pravatar.cc/150")
        )
    }
}
