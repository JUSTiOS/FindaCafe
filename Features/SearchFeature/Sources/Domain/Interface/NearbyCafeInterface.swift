import SwiftUI
import Combine

protocol NearbyCafeInterface {
    func getNearbyCafeList(url: String) -> AnyPublisher<NearbyCafeEntity, Error>
}
