import Foundation

struct OrderDto: Encodable {
    let nfts: [String]?
}

struct PutOrderAndPayRequest: NetworkRequest {

    var endpoint: URL? {
        URL(string: "\(RequestConstants.baseURL)/api/v1/orders/1")
    }
    var httpMethod: HttpMethod = .put
    var dto: OrderDto
}
