import SwiftUI
import Combine

class NearbyCafeRepository: NearbyCafeInterface {
    private var networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func getNearbyCafeList(url: String, longitude: String, latitude: String) -> AnyPublisher<NearbyCafeDTO, Error> {
        return networkService.downloadData(url: url, longitude: longitude, latitude: latitude)
    }
}
