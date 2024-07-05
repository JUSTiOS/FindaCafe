import SwiftUI
import Combine

public class SearchCafeTableViewModel: ObservableObject {
    private let nearbyCafeUsecase: NearbyCafeUsecaseProtocol
    private var cancellable: Set<AnyCancellable> = Set<AnyCancellable>()
    
    @Published var nearbyCafes: [NearbyCafeEntity] = []
    @Published var update: Bool = false
    
    private var nearbyCafeURL = "https://dapi.kakao.com/v2/local/search/category.json"
    
    init(nearbyCafeUsecase: NearbyCafeUsecaseProtocol) {
        self.nearbyCafeUsecase = nearbyCafeUsecase
    }
    
    func getNearbyCafeList(myLocation: MyLocationEntity) {
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
