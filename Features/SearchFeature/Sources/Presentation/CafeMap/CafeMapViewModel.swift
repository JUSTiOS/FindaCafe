import SwiftUI
import Combine

public final class CafeMapViewModel: ObservableObject {
    private let myLocationUseCase: NowLocationUseCaseInterface
    private var myLoc: Set<AnyCancellable> = Set<AnyCancellable>()
    
    @Published var myLocation: MyLocationEntity = MyLocationEntity(latitude: 0.0, longitude: 0.0)
    @Published var nearbyCafes: [NearbyCafeEntity] = []
    
    init(myLocationUseCase: NowLocationUseCaseInterface) {
        self.myLocationUseCase = myLocationUseCase
    }
    
    func getMyLocation() {
        myLocationUseCase.execute()
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(_):
                    self.myLocation = MyLocationEntity(latitude: 0.0, longitude: 0.0)
                }
            } receiveValue: { myLocation in
                self.myLocation = myLocation
                print("myLocation -> ", self.myLocation)
            }
            .store(in: &myLoc)
    }
}
