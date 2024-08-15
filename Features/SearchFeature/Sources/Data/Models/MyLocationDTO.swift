import SwiftUI
import Combine

final class MyLocationDTO: ObservableObject {
    @Published var latitude: Double
    @Published var longitude: Double
    
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
    
    func setLocation(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
    
    func getLocation() -> MyLocationEntity {
        return MyLocationEntity(latitude: self.latitude, longitude: longitude)
    }
}
