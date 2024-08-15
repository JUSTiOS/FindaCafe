import SwiftUI
import KakaoMapsSDK

struct KakaoMapView: UIViewRepresentable {
    var coordinator: KakaoMapCoordinator
    @Binding var draw: Bool
    
    var myLocation: MyLocationEntity?
    var nearbyCafes: [NearbyCafeEntity]
    
    func makeUIView(context: Self.Context) -> KMViewContainer {
        let view: KMViewContainer = KMViewContainer(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        context.coordinator.createController(view)
        return view
    }
    
    func updateUIView(_ uiView: KMViewContainer, context: Self.Context) {
        if draw {
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                if context.coordinator.controller?.isEnginePrepared == false {
                    context.coordinator.controller?.prepareEngine()
                }
                
                if context.coordinator.controller?.isEngineActive == false {
                    context.coordinator.controller?.activateEngine()
                }
            }
        } else {
            context.coordinator.controller?.pauseEngine()
            context.coordinator.controller?.resetEngine()
        }
    }
    
    func makeCoordinator() -> KakaoMapCoordinator {
        coordinator.myLocation = myLocation
        coordinator.nearbyCafes = nearbyCafes
        return coordinator
    }
}
