import Combine

protocol NowLocationUseCaseProtocol {
    func execute() -> AnyPublisher<MyLocationEntity, Never>
}

final class NowLocationUseCase: NowLocationUseCaseProtocol {
    private let repository: NowLocationInterface
    
    init(repository: NowLocationInterface) {
        self.repository = repository
    }
    
    func execute() -> AnyPublisher<MyLocationEntity, Never> {
        return repository.getNowLocation()
    }
}
