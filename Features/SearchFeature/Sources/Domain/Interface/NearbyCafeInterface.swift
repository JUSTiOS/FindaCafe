import SwiftUI
import Combine

protocol NearbyCafeInterface {
    func getNearbyCafeList(url: String, longitude: String, latitude: String, page: String) -> AnyPublisher<NearbyCafeDTO, Error>
}
