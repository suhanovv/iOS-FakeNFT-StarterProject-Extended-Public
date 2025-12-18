//
//  ProfileUpdateRequest.swift
//  iOS-FakeNFT-Extended
//
//  Created by Ди Di on 05/12/25.
//

import Foundation

struct ProfileUpdateRequest {
    let name: String?
    let avatar: URL?
    let description: String?
    let website: URL?
    let likes: [String]?
}

extension ProfileUpdateRequest {
    func toFormUrlEncoded() -> Data? {
        var components: [String] = []
        
        func encode(_ value: String) -> String {
            value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? value
        }
        
        if let name = name {
            components.append("name=\(encode(name))")
        }
        
        if let avatar = avatar {
            components.append("avatar=\(encode(avatar.absoluteString))")
        }
        
        if let description = description {
            components.append("description=\(encode(description))")
        }
        
        if let website = website {
            components.append("website=\(encode(website.absoluteString))")
        }
        
        if let likes = likes {
            let joined = likes.joined(separator: ",")
            components.append("likes=\(encode(joined))")
        }
        
        let bodyString = components.joined(separator: "&")
        return bodyString.data(using: String.Encoding.utf8)
    }
}
