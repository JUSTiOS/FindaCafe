import CommonCoreData

protocol CafeUpdateUsecaseProtocol {
    func execute(cafe: Cafe) async throws
}

final class CafeUpdateUsecase: CafeUpdateUsecaseProtocol {
    private let repository: CoreDataInterface
    
    init(repository: CoreDataInterface) {
        self.repository = repository
    }
    
    func execute(cafe: Cafe) async throws{
        try await repository.updateCafe(cafe)
    }
}
