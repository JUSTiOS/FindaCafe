import SwiftUI
import Combine

public final class SearchCafeTabViewModel: ObservableObject {
    private let myLocationUsecase: NowLocationUseCaseProtocol
    private let nearbyCafeUsecase: NearbyCafeUsecaseProtocol
    private var cancellable: Set<AnyCancellable> = Set<AnyCancellable>()
    
    @Published var myLocation: MyLocationEntity = MyLocationEntity(latitude: 0.0, longitude: 0.0)
    @Published var nearbyCafes: [NearbyCafeEntity] = []
    @Published var draw: Bool = false
    @Published var locationUpdated: Bool = false
    @State var searchText: String = ""
    
    @Published var update: Bool = false
    
    private var nearbyCafeURL = "https://dapi.kakao.com/v2/local/search/category.json"
    
    init(myLocationUseCase: NowLocationUseCaseProtocol, nearbyCafeUseCase: NearbyCafeUsecaseProtocol) {
        self.myLocationUsecase = myLocationUseCase
        self.nearbyCafeUsecase = nearbyCafeUseCase
    }
    
    func getMyLocation() {
        myLocationUsecase.execute()
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
    
    func getNearbyCafeList() {
        nearbyCafeUsecase.execute(url: nearbyCafeURL, standard: myLocation)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(_):
                    self.nearbyCafes = []
                }
            } receiveValue: { nearbyCafes in
                self.nearbyCafes = nearbyCafes
                self.update = true
            }
            .store(in: &cancellable)
    }
}
