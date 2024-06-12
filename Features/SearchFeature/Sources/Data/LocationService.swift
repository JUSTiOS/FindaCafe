import Combine
import CoreLocation
import SwiftUI

class LocationSevice: NSObject, CLLocationManagerDelegate, ObservableObject {
    private let manager = CLLocationManager()
    var myLocation: CLLocation = CLLocation()
    var authorizationSubject = PassthroughSubject<CLLocation, Never>()
    
    override init() {
        super.init()
        
        manager.delegate = self
        locationManagerAuthorization()
        
        let subscriber = self.authorizationSubject.sink { value in
            self.myLocation = value
        }
    }
    
    func locationManagerAuthorization() {
        manager.delegate = self
        
        switch manager.authorizationStatus {
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            break
        default:
            manager.startMonitoringVisits()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let nowLocation = locations.last else {
            return
        }
        authorizationSubject.send(nowLocation)
    }
}
