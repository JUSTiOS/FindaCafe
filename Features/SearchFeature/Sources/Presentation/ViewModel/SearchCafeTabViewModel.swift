import SwiftUI
import Combine

public final class SearchCafeTabViewModel: ObservableObject {
    private let myLocationUseCase: NowLocationUseCaseInterface
    private var cancellable: Set<AnyCancellable> = Set<AnyCancellable>()
    
    @Published var myLocation: MyLocationEntity = MyLocationEntity(latitude: 0.0, longitude: 0.0)
    @Published var nearbyCafes: [NearbyCafeEntity] = []
    @Published var draw: Bool = false
    @Published var locationUpdated: Bool = false
    @State var searchText: String = ""
    
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
                self.locationUpdated = true
            }
            .store(in: &cancellable)
    }
}
