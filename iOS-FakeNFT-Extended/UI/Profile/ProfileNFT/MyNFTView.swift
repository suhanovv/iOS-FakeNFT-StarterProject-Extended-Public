//
//  MyNFTView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Ди Di on 12/12/25.
//

import SwiftUI

// MARK: - Constants
private enum Constants {
    // Titles
    static let title = "Мои NFT"
    
    // Dialog
    static let nftDialogTitle = "Сортировка"
    static let byPrice = "По цене"
    static let byRating = "По рейтингу"
    static let byName = "По названию"
    static let close = "Закрыть"
}

enum NftSortType {
    case byPrice
    case byRating
    case byName
}

// MARK: - MyNFTView
struct MyNFTView: View {
    let nfts: [NftItem]
    @State private var isNftMenuPresented = false
    @State private var sortType: NftSortType = .byName
    
    private var sortedNfts: [NftItem] {
           switch sortType {
           case .byPrice:
               return nfts.sorted { ($0.price ?? 0) < ($1.price ?? 0) }

           case .byRating:
               return nfts.sorted { ($0.rating ?? 0) > ($1.rating ?? 0) }

           case .byName:
               return nfts.sorted { ($0.name ?? "") < ($1.name ?? "") }
           }
       }
    
    var body: some View {
        List {
            ForEach(sortedNfts) { nft in
                MyNFTCell(nft: nft, rating: nft.rating ?? 0)
                    .padding(.leading, 16)
                    .padding(.trailing, 39)
                    .padding(.vertical, 16)
                    .listRowInsets(EdgeInsets())
                    .listRowSeparator(.hidden)
            }
        }
        .listStyle(.plain)
        .padding(.vertical, 20)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    isNftMenuPresented = true
                } label: {
                    Image(.CommonIcons.sort)
                        .foregroundColor(.ypBlack)
                }
            }
        }
        .confirmationDialog(
            Text(Constants.nftDialogTitle),
            isPresented: $isNftMenuPresented,
            titleVisibility: .visible
        ) {
            Button(Constants.byPrice) {
                sortType = .byPrice
            }
            
            Button(Constants.byRating) {
                sortType = .byRating
            }
            
            Button(Constants.byName) {
                sortType = .byName
            }
            
            Button(Constants.close, role: .cancel) {}
        }
    }
}

// MARK: - Preview_MyNFTView
#Preview {
    NavigationStack {
        MyNFTView(nfts: ProfileViewMock.mockNFTs)
    }
}
