//
//  CatalogueView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Diana Viter on 09.12.2025.
//

import SwiftUI

struct CatalogueView: View {
    let collections: [CollectionDTO]
    
    init(collections: [CollectionDTO] = MockData.collections) {
        self.collections = collections
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Spacer()
                
                Button {
                    // TODO: сортировка
                } label: {
                    Image("Common Icons/Sort")
                        .renderingMode(.template)
                        .foregroundStyle(.ypBlackUniversal)
                }
                .padding(.trailing, 16)
                .padding(.top, 16)
            }
            
            ScrollView {
                VStack(spacing: 24) {
                    ForEach(collections) { collection in
                        NavigationLink {
                            CollectionView(collection: collection)
                                .navigationBarBackButtonHidden(true)
                        } label: {
                            CatalogueCellView(collection: collection)
                                .contentShape(Rectangle())
                                .foregroundColor(.primary)
                        }
                    }
                }
                .padding(.top, 16)
                .padding(.bottom, 16)
            }
        }
    }
}


#Preview {
    NavigationStack {
        CatalogueView()
    }
}
