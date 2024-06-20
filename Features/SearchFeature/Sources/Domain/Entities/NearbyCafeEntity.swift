import Foundation

struct NearbyCafeEntity {
    let cafeName: String
    let distance: Double
    let latitude: Double
    let longitude: Double
    
    init(cafeName: String, distance: Double, latitude: Double, longitude: Double) {
        self.cafeName = cafeName
        self.distance = distance
        self.latitude = latitude
        self.longitude = longitude
    }
}
