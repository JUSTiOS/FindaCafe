import SwiftUI
import Combine

public final class KakaoMapViewModel: ObservableObject {
    @Published var myLocation: MyLocationEntity = MyLocationEntity(latitude: 0.0, longitude: 0.0)
}
