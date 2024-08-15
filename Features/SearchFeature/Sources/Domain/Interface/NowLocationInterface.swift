import Combine

protocol NowLocationInterface {
    func getNowLocation() -> AnyPublisher<MyLocationEntity, Never>
}
