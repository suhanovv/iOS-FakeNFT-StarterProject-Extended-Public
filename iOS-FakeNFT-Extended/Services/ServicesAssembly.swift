import Foundation

@Observable
@MainActor
final class ServicesAssembly {
    
    private let networkClient: NetworkClient
    private let nftStorage: NftStorage
    
    init(
        networkClient: NetworkClient,
        nftStorage: NftStorage
    ) {
        self.networkClient = networkClient
        self.nftStorage = nftStorage
    }
    
    var nftService: NftService {
        NftServiceImpl(networkClient: networkClient, storage: nftStorage)
    }
    
    var collectionsService: CollectionsServiceProtocol {
        CollectionsServiceActor(networkClient: networkClient)
    }
    
    var collectionService: CollectionServiceProtocol {
        CollectionServiceActor(networkClient: networkClient)
    }
    
    var userService: UsersServiceProtocol {
        UsersService(networkClient: networkClient)
    }
    
    var orderService: OrderServiceProtocol {
        OrderService(networkClient: networkClient)
    }

    var profileService: ProfileServiceProtocol {
        ProfileService(networkClient: networkClient)
    }
}


