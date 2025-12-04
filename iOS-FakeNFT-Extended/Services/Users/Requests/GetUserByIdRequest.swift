import Foundation

struct GetUserByIdRequest: NetworkRequest {

    let userId: String

    var endpoint: URL? {
        URL(string: "\(RequestConstants.baseURL)/api/v1/users/\(userId)")
    }
}
