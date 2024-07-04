import SwiftUI
import Combine

class SearchCafeTableViewModel: ObservableObject {
    private let nearbyCafeUsecase: NearbyCafeUsecaseProtocol
    
    init(nearbyCafeUsecase: NearbyCafeUsecaseProtocol) {
        self.nearbyCafeUsecase = nearbyCafeUsecase
    }}
