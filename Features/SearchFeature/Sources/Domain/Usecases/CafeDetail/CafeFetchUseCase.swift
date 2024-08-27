import CommonCoreData

private protocol CafeFetchUseCaseProtocol {
    func execute(cafe: Cafe) async throws -> [Cafe]
}

final class CafeFetchUseCase: FetchCafeUseCaseProtocol {
    private let repository: CoreDataInterface
    
    init(repository: CoreDataInterface) {
        self.repository = repository
    }
    
    func execute(cafe: Cafe) async throws -> [Cafe] {
        return try await repository.fetchCafes()
    }
}
