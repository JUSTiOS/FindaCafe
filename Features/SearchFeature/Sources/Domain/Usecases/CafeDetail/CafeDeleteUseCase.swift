import CommonCoreData

protocol CafeDeleteUseCaseProtocol {
    func execute(cafe: Cafe) async throws
}

final class CafeDeleteUseCase: CafeDeleteUseCaseProtocol {
    private let repository: CoreDataInterface
    
    init(repository: CoreDataInterface) {
        self.repository = repository
    }
    
    func execute(cafe: Cafe) async throws {
        try await repository.deleteCafe(cafe)
    }
}
