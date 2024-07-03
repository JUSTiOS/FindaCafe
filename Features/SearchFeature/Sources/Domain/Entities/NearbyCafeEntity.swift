import SwiftUI

class NearbyCafeEntity: ObservableObject {
    @Published var cafeName: String
    @Published var distance: String
    @Published var latitude: String
    @Published var longitude: String
    
    init(cafeName: String, distance: String, latitude: String, longitude: String) {
        self.cafeName = cafeName
        self.distance = distance
        self.latitude = latitude
        self.longitude = longitude
    }
}
