import Foundation

struct OrderDto: Encodable {
    let nfts: [String]?
    
    private enum CodingKeys: String, CodingKey {
        case nfts
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(nfts, forKey: .nfts)
    }
}

struct PutOrderRequest: NetworkRequest, @unchecked Sendable {
    var endpoint: URL? {
        URL(string: "\(RequestConstants.baseURL)/api/v1/orders/1")
    }
    var httpMethod: HttpMethod = .put
    var dto: Encodable?
    var contentType: ContentType? = .formUrlEncoded
}
