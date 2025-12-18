import Foundation

struct UpdateLikesDto: Encodable {
    let likes: [String]?
    
    private enum CodingKeys: String, CodingKey {
        case likes
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(likes, forKey: .likes)
    }
}

struct UpdateLikesRequest: NetworkRequest, @unchecked Sendable {
    var dto: Encodable?
    var endpoint: URL? {
        URL(string: "\(RequestConstants.baseURL)/api/v1/profile/1")
    }
    var httpMethod: HttpMethod = .put
    var contentType: ContentType? = .formUrlEncoded
}
