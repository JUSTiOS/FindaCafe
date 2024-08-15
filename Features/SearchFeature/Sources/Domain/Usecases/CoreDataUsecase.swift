protocol CoreDataUsecaseProtocol {
    func execute() -> Result<CafeInfo, CoreDataError>
}

final class CoreDataUsecase: CoreDataUsecaseProtocol {
    private let repository: CoreDataInterface
    
    init(repository: CoreDataInterface) {
        self.repository = repository
    }
    
    func execute() -> Result<CafeInfo, CoreDataError> {
        return repository.getCafeInfo()
    }
}
