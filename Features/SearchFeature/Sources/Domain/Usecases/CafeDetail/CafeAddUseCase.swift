import CommonCoreData

protocol CafeAddUseCaseProtocol {
    func execute(cafe: Cafe) async throws
}

final class CafeAddUseCase: CafeAddUseCaseProtocol {
    private let repository: CoreDataInterface
    
    init(repository: CoreDataInterface) {
        self.repository = repository
    }
    
    func execute(cafe: Cafe) async throws {
        try await repository.addCafe(cafe)
    }
}
