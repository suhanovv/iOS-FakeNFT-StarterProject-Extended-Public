//
//  UpdateProfileRequest.swift
//  iOS-FakeNFT-Extended
//
//  Created by Ди Di on 21/12/25.
//

import Foundation

struct UpdateProfileRequest: NetworkRequest, @unchecked Sendable {
    typealias Response = User
    
    let dto: Encodable?
    
    var endpoint: URL? {
        URL(string: "\(RequestConstants.baseURL)/api/v1/profile/1")
    }
    
    var httpMethod: HttpMethod {
        .put
    }
    
    var contentType: ContentType? {
        .formUrlEncoded
    }
}
