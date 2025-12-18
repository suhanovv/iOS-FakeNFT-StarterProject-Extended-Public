import Foundation

enum NetworkClientError: Error {
    case httpStatusCode(Int)
    case urlRequestError(Error)
    case urlSessionError
    case parsingError
    case incorrectRequest(String)
}

protocol NetworkClient: Sendable {
    func send(request: NetworkRequest) async throws -> Data
    func send<T: Decodable>(request: NetworkRequest) async throws -> T
}

actor DefaultNetworkClient: NetworkClient {
    private let session: URLSession
    private let decoder: JSONDecoder
    private let encoder: JSONEncoder
    
    init(
        session: URLSession = URLSession.shared,
        decoder: JSONDecoder = JSONDecoder(),
        encoder: JSONEncoder = JSONEncoder()
    ) {
        self.session = session
        self.decoder = decoder
        self.encoder = encoder
    }
    
    func send(request: NetworkRequest) async throws -> Data {
        let urlRequest = try create(request: request)
        let (data, response) = try await session.data(for: urlRequest)
        guard let response = response as? HTTPURLResponse else {
            throw NetworkClientError.urlSessionError
        }
        guard 200 ..< 300 ~= response.statusCode else {
            throw NetworkClientError.httpStatusCode(response.statusCode)
        }
        return data
    }
    
    func send<T: Decodable & Sendable>(request: NetworkRequest) async throws -> T {
        let data = try await send(request: request)
        return try await parse(data: data)
    }
    
    // MARK: - Private
    
    private func create(request: NetworkRequest) throws -> URLRequest {
        guard let endpoint = request.endpoint else {
            throw NetworkClientError.incorrectRequest("Empty endpoint")
        }
        
        var urlRequest = URLRequest(url: endpoint)
        urlRequest.httpMethod = request.httpMethod.rawValue
        
        if let dto = request.dto,
           let contentType = request.contentType {
            switch contentType {
                case .json: urlRequest.httpBody = makeJsonData(dto: dto)
                case .formUrlEncoded: urlRequest.httpBody = makeFormUrlEncodedData(dto: dto)
            }
            urlRequest.setValue(contentType.rawValue, forHTTPHeaderField: "Content-Type")
        }
        urlRequest.addValue(RequestConstants.token, forHTTPHeaderField: "X-Practicum-Mobile-Token")
        
        return urlRequest
    }
    
    private func makeJsonData(dto: Encodable) -> Data? {
        return try? encoder.encode(dto)
    }
    
    private func makeFormUrlEncodedData(dto: Encodable) -> Data? {
        if let encodedData = try? encoder.encode(dto),
           let dict = try? JSONSerialization.jsonObject(with: encodedData, options: .fragmentsAllowed) as? [String : Any] {
            let allParams = dict.reduce(into: [String]()) { (data, pair) in
                let stringValue = switch pair.value.self {
                    case is NSNull: "null"
                    case is [String]:
                        if let values = pair.value as? [String],
                           values.count > 0 {
                            values.joined(separator: ",")
                        } else {
                            "null"
                        }
                    default: pair.value
                }
                data.append("\(pair.key)=\(stringValue)")
            }
            var allowedCharacters = CharacterSet.urlQueryAllowed
            allowedCharacters.remove(charactersIn: ",")
            
            return allParams
                .joined(separator: "&")
                .addingPercentEncoding(withAllowedCharacters: allowedCharacters)?
                .data(using: .utf8)
        }
        return nil
    }
    
    private func parse<T: Decodable>(data: Data) async throws -> T {
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw NetworkClientError.parsingError
        }
    }
}
