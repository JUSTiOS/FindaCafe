import Combine

class MyLocationRepository: NowLocationInterface {
    private var nowLocationService: NowLocationSevice
    
    init(nowLocationService: NowLocationSevice) {
        self.nowLocationService = nowLocationService
    }
    
    func getNowLocation() -> AnyPublisher<MyLocationEntity, Never> {
        return nowLocationService.getNowLocation()
            .map { dto in
                MyLocationEntity(latitude: dto.latitude, longitude: dto.longitude)
            }
            .eraseToAnyPublisher()
    }
}
