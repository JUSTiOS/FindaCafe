import SwiftUI
import Combine

protocol NearbyCafeUsecaseProtocol {
    func execute(url: String, page: String, standard: MyLocationEntity) -> AnyPublisher<[NearbyCafeEntity], Error>
}

class NearbyCafeUsecase: NearbyCafeUsecaseProtocol {
    private let repository: NearbyCafeInterface
    
    init(repository: NearbyCafeInterface) {
        self.repository = repository
    }
    
    func execute(url: String, page: String, standard: MyLocationEntity) -> AnyPublisher<[NearbyCafeEntity], Error> {
        let longitude = String(standard.longitude)
        let latitude = String(standard.latitude)
        
        return repository.getNearbyCafeList(url: url, longitude: longitude, latitude: latitude, page: page)
            .map { $0.documents
                    .map { $0.toDomain() }
                    .filter { return $0.categoryName.split(separator: " > ").contains("음식점") }
            }
            .eraseToAnyPublisher()
    }
}
