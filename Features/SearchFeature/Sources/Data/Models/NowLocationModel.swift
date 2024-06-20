import SwiftUI

final class NowLocationModel: ObservableObject {
    private(set) var latitude: Double = 37.402001
    private(set) var longitude: Double = 127.108678
    
    func setLocation(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
    
    func getLocation() -> MyLocationEntity {
        return MyLocationEntity(latitude: self.latitude, longitude: longitude)
    }
}

