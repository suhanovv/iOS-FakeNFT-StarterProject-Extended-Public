//
//  Constants.swift
//  iOS-FakeNFT-Extended
//
//  Created by Ди Di on 12/12/25.
//

import Foundation

enum Constants {
    
    // MARK: - Storage Keys
    enum StorageKeys {
        static let name = "profile_name"
        static let description = "profile_description"
        static let website = "profile_website"
        static let photoURL = "profile_photo_url"
        static let favouriteNFTIds = "favourite_nft_ids"
        static let profileName = NSLocalizedString("Profile.name", comment: "")
        static let profileDescription = NSLocalizedString("Profile.description", comment: "")
        static let profileWebsite = NSLocalizedString("Profile.website", comment: "")
        static let photoAlertPh = NSLocalizedString("Profile.photoAlert.placeholder", comment: "")
    }
    
    // MARK: - Common Buttons
    enum Buttons {
        static let cancel = NSLocalizedString("Profile.cancelButton", comment: "")
        static let save = NSLocalizedString("Profile.saveButton", comment: "")
        static let sortByPrice = NSLocalizedString("Profile.sorting.byPriceButton", comment: "")
        static let sortByRating = NSLocalizedString("Profile.sorting.byRatingButton", comment: "")
        static let sortByName = NSLocalizedString("Profile.sorting.byNameButton", comment: "")
        static let close = NSLocalizedString("Profile.sorting.closeButton", comment: "")
        static let exitConfirmation = NSLocalizedString("Profile.exitAlert.exitButton", comment: "")
        static let stayConfirmation = NSLocalizedString("Profile.exitAlert.stayButton", comment: "")
        static let changePhoto = NSLocalizedString("Profile.photoDialog.changePhoto", comment: "")
        static let deletePhoto = NSLocalizedString("Profile.photoDialog.deletePhoto", comment: "")
    }
    
    // MARK: - Titles
    enum Titles {
        static let profile = NSLocalizedString("Tab.profile", comment: "")
        static let myNFT = NSLocalizedString("Profile.myNFT", comment: "")
        static let favouriteNFT = NSLocalizedString("Profile.favouriteNFT", comment: "")
        static let sortNFT = NSLocalizedString("Profile.sorting.title", comment: "")
        static let exitAlert = NSLocalizedString("Profile.exitAlert.title", comment: "")
        static let photoAlert = NSLocalizedString("Profile.photoAlert.title", comment: "")
        static let photoDialog = NSLocalizedString("Profile.photoDialog.title", comment: "")
        static let price = NSLocalizedString("Profile.price", comment: "")
    }
}
