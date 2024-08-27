import SwiftUI
import CommonCoreData

final class CafeDetailViewModel {
    private var cafeAddUseCase: CafeAddUseCaseProtocol
    private var cafeUpdateUseCase: CafeUpdateUsecaseProtocol
    private var cafeFetchUseCase: CafeFetchUseCaseProtocol
    private var cafeDeleteUseCase: CafeDeleteUseCaseProtocol
    
    init(cafeAddUseCase: CafeAddUseCaseProtocol, cafeUpdateUseCase: CafeUpdateUsecaseProtocol, cafeFetchUseCase: CafeFetchUseCaseProtocol, cafeDeleteUseCase: CafeDeleteUseCaseProtocol) {
        self.cafeAddUseCase = cafeAddUseCase
        self.cafeUpdateUseCase = cafeUpdateUseCase
        self.cafeFetchUseCase = cafeFetchUseCase
        self.cafeDeleteUseCase = cafeDeleteUseCase
    }
    
    func addCafeList(cafe: Cafe) async throws {
        try await cafeAddUseCase.execute(cafe: cafe)
    }
    
    func deleteCafeList(cafe: Cafe) async throws {
        try await cafeDeleteUseCase.execute(cafe: cafe)
    }
    
    func updateCafeList(cafe: Cafe) async throws {
        try await cafeUpdateUseCase.execute(cafe: cafe)
    }
    
    func fetchCafeList(cafe: Cafe) async throws -> [Cafe] {
        return try await cafeFetchUseCase.execute(cafe: cafe)
    }
}
