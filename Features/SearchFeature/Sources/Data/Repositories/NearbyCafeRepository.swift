//import SwiftUI
//import Combine
//
//class NearbyCafeRepository: NearbyCafeInterface {
//    private var networkService: NetworkService
//    
//    init(networkService: NetworkService) {
//        self.networkService = networkService
//    }
//    
//    func getNearbyCafeList(url: String) -> AnyPublisher<NearbyCafeEntity, Error> {
//        return networkService.downloadData(url: url)
//    }
//    
//    func fetchNearbyCafe() -> AnyPublisher<NearbyCafeEntity, Error> {
//    }
//}
