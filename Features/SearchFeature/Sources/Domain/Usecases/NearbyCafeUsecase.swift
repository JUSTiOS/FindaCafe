//import SwiftUI
//import Combine
//
//protocol NearbyCafeUsecaseProtocol {
//    func execute() -> AnyPublisher<NearbyCafeEntity, Error>
//}
//
//class NearbyCafeUsecase: NearbyCafeUsecaseProtocol {
//    private let repository: NearbyCafeInterface
//    
//    init(repository: NearbyCafeInterface) {
//        self.repository = repository
//    }
//    
//    func execute() -> AnyPublisher<NearbyCafeEntity, Error> {
//        return repository.getNearbyCafeList(url: "")
//            
//    }
//}
