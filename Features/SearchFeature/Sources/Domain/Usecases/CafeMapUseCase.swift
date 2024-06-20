import Combine

protocol NowLocationUseCaseInterface {
    func execute() -> AnyPublisher<MyLocationEntity, Never>
}

final class NowLocationUseCase: NowLocationUseCaseInterface {
    private let repository: NowLocationInterface
    
    init(repository: NowLocationInterface) {
        self.repository = repository
    }
    
    func execute() -> AnyPublisher<MyLocationEntity, Never> {
        return repository.getNowLocation()
    }
}
