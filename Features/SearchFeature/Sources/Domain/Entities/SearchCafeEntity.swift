import SwiftUI

class SearchCafeEntity: ObservableObject {
    @Published var name: String
    @Published var address: String
    @Published var distance: String
    
    init(name: String, address: String, distance: String) {
        self.name = name
        self.address = address
        self.distance = distance
    }
}
