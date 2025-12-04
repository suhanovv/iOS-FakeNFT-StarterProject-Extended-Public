import Foundation

protocol OrderAndPaymentServiceProtocol {
    func getOrder() async throws -> Order
    func addToCartNft(_ nftId: String) async throws -> Order
    func removeFromCartNft(_ nftId: String) async throws -> Order
    func clearCart() async throws -> Order
}
