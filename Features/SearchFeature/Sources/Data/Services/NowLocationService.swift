import CoreLocation
import Combine
import SwiftUI

class NowLocationSevice: NSObject, CLLocationManagerDelegate, ObservableObject {
    @ObservedObject private var nowLocation: MyLocationDTO = MyLocationDTO(latitude: 0.0, longitude: 0.0)
    
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
        case .authorizedAlways, .authorizedWhenInUse:
            manager.startUpdatingLocation()
        default:
            print("권한 허용이 필요합니다. 설정에서 권한 설정을 해주세요.")
        }
    }
    
    func getNowLocation() -> AnyPublisher<MyLocationDTO, Never> {
        return nowLocation.$latitude
            .combineLatest(nowLocation.$longitude)
            .map { latitude, longitude in
                MyLocationDTO(latitude: latitude, longitude: longitude)
            }
            .eraseToAnyPublisher()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        nowLocation.setLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined, .restricted, .denied:
            print("권한 허용이 필요합니다")
        default:
            manager.startUpdatingLocation()
            nowLocation = MyLocationDTO(latitude: CLLocation().coordinate.latitude, longitude: CLLocation().coordinate.longitude)
        }
        
    }
}
