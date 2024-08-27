import CommonCoreData

protocol CafeFetchUseCaseProtocol {
    func execute(cafe: Cafe) async throws -> [Cafe]
}

final class CafeFetchUseCase: CafeFetchUseCaseProtocol {
    private let repository: CoreDataInterface
    
    init(repository: CoreDataInterface) {
        self.repository = repository
    }
    
    func execute(cafe: Cafe) async throws -> [Cafe] {
        return try await repository.fetchCafes()
    }
}
