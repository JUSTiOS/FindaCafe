import Combine

class NowLocationRepository: NowLocationInterface {
    private var nowLocationService: NowLocationSevice
    
    init(nowLocationService: NowLocationSevice) {
        self.nowLocationService = nowLocationService
    }
    
    func getNowLocation() -> AnyPublisher<MyLocationEntity, Never> {
        return nowLocationService.getNowLocation()
    }
}
