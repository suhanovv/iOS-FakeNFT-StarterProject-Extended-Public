import Foundation

import Foundation

@Observable
@MainActor
final class ServicesAssembly {

    private let networkClient: NetworkClient
    private let nftStorage: NftStorage

    init(networkClient: NetworkClient, nftStorage: NftStorage) {
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
<<<<<<< HEAD
    }
    
    var userService: UsersServiceProtocol {
        UsersService(networkClient: networkClient)
    }
    
    var profileService: ProfileServiceProtocol {
        ProfileService(networkClient: networkClient)
    }

    var collectionsService: CollectionsServiceProtocol {
        CollectionsService()
=======
>>>>>>> 86f145d (feat: add actor-based networking and concurrency-safe catalogue services)
    }
    
    var userService: UsersServiceProtocol {
        UsersService(networkClient: networkClient)
    }
    
    var profileService: ProfileServiceProtocol {
        ProfileService(networkClient: networkClient)
    }
    
    var orderService: OrderServiceProtocol {
        OrderService(networkClient: networkClient)
    }
}


