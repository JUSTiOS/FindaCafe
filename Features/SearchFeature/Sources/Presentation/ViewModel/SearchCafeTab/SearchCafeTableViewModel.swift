import SwiftUI
import Combine

public class SearchCafeTableViewModel: ObservableObject {
    private let nearbyCafeUsecase: NearbyCafeUsecaseProtocol
    private var cancellable: Set<AnyCancellable> = Set<AnyCancellable>()
    
    @Published var nearbyCafes: [NearbyCafeEntity] = []
    @Published var update: Bool = false
    @Published var selectedCafe: NearbyCafeEntity
    
    private var nearbyCafeURL = "https://dapi.kakao.com/v2/local/search/category.json"
    var page = 1
    
    init(nearbyCafeUsecase: NearbyCafeUsecaseProtocol) {
        self.nearbyCafeUsecase = nearbyCafeUsecase
        self.selectedCafe = NearbyCafeEntity(cafeName: "", distance: "", latitude: "", longitude: "", categoryName: "", address: "")
    }
    
    func getNearbyCafeList(myLocation: MyLocationEntity) {
        nearbyCafeUsecase.execute(url: nearbyCafeURL, page: String(page), standard: myLocation)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(_):
                    self.nearbyCafes = []
                }
            } receiveValue: { nearbyCafes in
                if nearbyCafes.isEmpty {
                    return
                }
                
                self.nearbyCafes = nearbyCafes.sortCafe()
                self.update = true
            }
            .store(in: &cancellable)
    }
}

