import SwiftUI
import Combine

protocol NearbyCafeInterface {
    func getNearbyCafeList(url: String, longitude: String, latitude: String) -> AnyPublisher<NearbyCafeDTO, Error>
}
