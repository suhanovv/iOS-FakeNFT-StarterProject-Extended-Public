import Foundation

struct UpdateLikesDto: Encodable {
    let likes: [String]
}

struct UpdateUserLikesRequest: NetworkRequest {

    let userId: Int

    var endpoint: URL? {
        URL(string: "\(RequestConstants.baseURL)/api/v1/profile/\(userId)")
    }
    var httpMethod: HttpMethod = .put
    var dto: UpdateLikesDto
}
