import CoreLocation
import Combine
import SwiftUI

class NowLocationSevice: NSObject, CLLocationManagerDelegate, ObservableObject {
    @ObservedObject private var nowLocation: MyLocationDTO = MyLocationDTO()
    
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
        return nowLocation.$latitude
            .combineLatest(nowLocation.$longitude)
            .map { latitude, longitude in
                MyLocationEntity(latitude: latitude, longitude: longitude)
            }
            .eraseToAnyPublisher()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        nowLocation.setLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
    }
}
