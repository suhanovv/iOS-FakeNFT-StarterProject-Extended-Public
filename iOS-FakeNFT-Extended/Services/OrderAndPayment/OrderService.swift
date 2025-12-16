import Foundation

protocol OrderServiceProtocol: Sendable {
    func getOrder() async throws -> Order
    func addToCartNft(_ nftId: String) async throws -> Order
    func removeFromCartNft(_ nftId: String) async throws -> Order
}

actor OrderService: OrderServiceProtocol {
    private let networkClient: NetworkClient
    
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    func getOrder() async throws -> Order {
        let request: GetOrderRequest = .init()
        return try await networkClient.send(request: request)
    }

    func addToCartNft(_ nftId: String) async throws -> Order {
        let currentOrder = try await getOrder()
        if !currentOrder.nfts.contains(nftId) {
            let newNfts: [String] = currentOrder.nfts + [nftId]
            return try await makeUpdateRequestAndSend(with: newNfts)
        }
        return currentOrder
    }

    func removeFromCartNft(_ nftId: String) async throws -> Order {
        let currentOrder = try await getOrder()
        let newNfts: [String] = currentOrder.nfts.filter { $0 != nftId }
        return try await makeUpdateRequestAndSend(with: newNfts)
    }
    
    private func makeUpdateRequestAndSend(with nfts: [String]) async throws -> Order {
        let orderDto = OrderDto(nfts: nfts)
        let putOrderRequest: PutOrderRequest = PutOrderRequest(dto: orderDto)
        return try await networkClient.send(request: putOrderRequest)
    }
}
