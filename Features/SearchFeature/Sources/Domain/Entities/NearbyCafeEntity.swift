import SwiftUI

class NearbyCafeEntity: ObservableObject, Identifiable {
    @Published var cafeName: String
    @Published var distance: String
    @Published var latitude: String
    @Published var longitude: String
    @Published var categoryName: String
    @Published var address: String
    
    init(cafeName: String, distance: String,
         latitude: String, longitude: String,
         categoryName: String, address: String) {
        self.cafeName = cafeName
        self.distance = distance
        self.latitude = latitude
        self.longitude = longitude
        self.categoryName = categoryName
        self.address = address
    }
}
