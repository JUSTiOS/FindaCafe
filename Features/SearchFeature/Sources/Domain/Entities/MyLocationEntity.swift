import SwiftUI

class MyLocationEntity: ObservableObject {
    @Published var latitude: Double
    @Published var longitude: Double
    
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}
