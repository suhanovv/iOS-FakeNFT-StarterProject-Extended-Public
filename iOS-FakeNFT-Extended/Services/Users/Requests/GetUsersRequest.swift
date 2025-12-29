import Foundation

struct GetUsersRequest: NetworkRequest {
    let page: Int
    let size: Int
    let sortBy: String
    
    var endpoint: URL? {
        URL(string: "\(RequestConstants.baseURL)/api/v1/users")?
            .appending(queryItems: [
                URLQueryItem(name: "page", value: "\(page)"),
                URLQueryItem(name: "size", value: "\(size)"),
                URLQueryItem(name: "sortBy", value: "\(sortBy),desc"),
            ])
    }
}
