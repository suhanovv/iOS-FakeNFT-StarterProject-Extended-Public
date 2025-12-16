//
//  SortingToolbarButtonView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Вадим Суханов on 09.12.2025.
//

import SwiftUI

struct SortingToolbarButtonView: View {
    @State private var isSortOptionsPresented: Bool = false
    @Bindable var viewModel: StatisticsScreenView.ViewModel
    @Binding var sortOrder: UsersSortType
    
    var body: some View {
        Button(action: {
            isSortOptionsPresented = true
        }, label: {
            Image(.CommonIcons.sort).foregroundStyle(.ypBlack)
        })
        .confirmationDialog(
            Constants.sortingConfirmationTitle,
            isPresented: $isSortOptionsPresented,
            titleVisibility: .visible
        ) {
            Button {
                sortOrder = .name
            } label: {
                Text(Constants.sortingByNameTitle)
            }
            Button {
                sortOrder = .rating
            } label: {
                Text(Constants.sortingByRatingTitle)
            }
            Button(Constants.sortingCloseTitle, role: .cancel) {
                isSortOptionsPresented = false
            }
            
        }
        .onChange(of: sortOrder) {
            Task {
                await viewModel.changeOrderBy(sortOrder)
            }
        }
    }
}

private enum Constants {
    static let sortingConfirmationTitle = NSLocalizedString("Catalog.sortingConfirmation.title", comment: "")
    static let sortingByNameTitle = NSLocalizedString("Catalog.sortingByName.title", comment: "")
    static let sortingByRatingTitle = NSLocalizedString("Catalog.sortingByRating.title", comment: "")
    static let sortingCloseTitle = NSLocalizedString("Catalog.sortingClose.title", comment: "")
}
