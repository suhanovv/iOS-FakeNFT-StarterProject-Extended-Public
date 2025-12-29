//
//  ProfileUpdateRequest.swift
//  iOS-FakeNFT-Extended
//
//  Created by Ди Di on 05/12/25.
//

import Foundation

struct ProfileUpdateRequest: Encodable {
    let name: String?
    let avatar: String?
    let description: String?
    let website: String?
    let likes: [String]?
    
    init(
        name: String? = nil,
        avatar: String? = nil,
        description: String? = nil,
        website: String? = nil,
        likes: [String]? = nil
    ) {
        self.name = name
        self.avatar = avatar
        self.description = description
        self.website = website
        self.likes = likes
    }
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
            components.append("avatar=\(encode(avatar))")
        }
        
        if let description = description {
            components.append("description=\(encode(description))")
        }
        
        if let website = website {
            components.append("website=\(encode(website))")
        }
        
        if let likes = likes {
            let joined = likes.joined(separator: ",")
            components.append("likes=\(encode(joined))")
        }
        
        let bodyString = components.joined(separator: "&")
        return bodyString.data(using: String.Encoding.utf8)
    }
}
