import CoreLocation
import Combine

class NowLocationSevice: NSObject, CLLocationManagerDelegate, ObservableObject {
    private var nowLocation: NowLocationModel = NowLocationModel()
    
    private let manager = CLLocationManager()
    
    override init() {
        super.init()
        manager.delegate = self
        requestLocationAuthorization()
    }
    
    func requestLocationAuthorization() {
        switch manager.authorizationStatus {
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            break
        case .authorizedAlways, .authorizedWhenInUse:
            manager.startUpdatingLocation()
        default:
            manager.requestWhenInUseAuthorization()
        }
    }
    
    func getNowLocation() -> AnyPublisher<MyLocationEntity, Never> {
        print("2")
        return Just(nowLocation.getLocation())
            .eraseToAnyPublisher()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        print("1")
        nowLocation.setLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
    }
}
