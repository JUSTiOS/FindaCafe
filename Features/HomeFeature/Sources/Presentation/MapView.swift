//
//  MapView.swift
//  HomeFeature
//
//  Created by Jaehun Lee on 6/10/24.
//

import SwiftUI
import KakaoMapsSDK

public struct MapView: UIViewRepresentable {    
    private let size: CGSize
    private let position: MapPoint
    
    public init(size: CGSize, position: Coord) {
        self.size = size
        self.position = MapPoint(longitude: position.longitude, latitude: position.latitude)
        SDKInitializer.InitSDK(appKey: "494ee3607df71d466a244c17cb4bd279")
    }
    
    public func makeUIView(context: Self.Context) -> KMViewContainer {
        let view: KMViewContainer = KMViewContainer(frame: .init(origin: .zero, size: size))
        view.sizeToFit()
        context.coordinator.createController(view)
        context.coordinator.controller?.prepareEngine()
        
        return view
    }

    public func updateUIView(_ uiView: KMViewContainer, context: Self.Context) {
        context.coordinator.controller?.activateEngine()
    }
    
    public func makeCoordinator() -> KakaoMapCoordinator {
        return KakaoMapCoordinator(position: position)
    }
    
    public static func dismantleUIView(_ uiView: KMViewContainer, coordinator: KakaoMapCoordinator) {
        coordinator.controller?.pauseEngine()
        coordinator.controller?.resetEngine()
    }
    
    public class KakaoMapCoordinator: NSObject, MapControllerDelegate {
        var controller: KMController?
        private var first: Bool
        private let position: MapPoint
        
        init(position: MapPoint) {
            first = true
            self.position = position
            super.init()
        }
        
        func createController(_ view: KMViewContainer) {
            controller = KMController(viewContainer: view)
            controller?.delegate = self
        }
        
        public func addViews() {
            let mapviewInfo: MapviewInfo = MapviewInfo(viewName: "mapview", viewInfoName: "map", defaultPosition: position)
            
            controller?.addView(mapviewInfo)
        }

        public func addViewSucceeded(_ viewName: String, viewInfoName: String) {
            let view = controller?.getView(viewName) as! KakaoMap
            createLabelLayer(for: view)
            createPoiStyle(for: view)
            createPoi(for: view)
        }
        
        private func createLabelLayer(for view: KakaoMap) {
            let labelManager = view.getLabelManager()
            let layerOption = LabelLayerOptions(
                layerID: "PoiLayer",
                competitionType: .none,
                competitionUnit: .symbolFirst,
                orderType: .rank,
                zOrder: 0
            )
            _ = labelManager.addLabelLayer(option: layerOption)
        }
        
        private func createPoiStyle(for view: KakaoMap) {
            let labelManager = view.getLabelManager()
            
            let iconStyle = PoiIconStyle(symbol: UIImage(systemName: "mappin"), anchorPoint: CGPoint(x: 0.5, y: 1))
            let poiStyle = PoiStyle(styleID: "PerLevelPoiStyle", styles: [PerLevelPoiStyle(iconStyle: iconStyle)])
            
            labelManager.addPoiStyle(poiStyle)
        }
        
        private func createPoi(for view: KakaoMap) {
            let labelManager = view.getLabelManager()
            let layer = labelManager.getLabelLayer(layerID: "PoiLayer")
            let poiOption = PoiOptions(styleID: "PerLevelPoiStyle")
            
            let poi = layer?.addPoi(option: poiOption, at: position)
            poi?.show()
        }
        
        public func addViewFailed(_ viewName: String, viewInfoName: String) {
            print("Failed")
        }
        
        public func containerDidResized(_ size: CGSize) {
            let mapView: KakaoMap? = controller?.getView("mapview") as? KakaoMap
            mapView?.viewRect = CGRect(origin: .zero, size: size)
//            if first {
//                let cameraUpdate: CameraUpdate = CameraUpdate.make(
//                    target: MapPoint(longitude: position.longitude, latitude: position.latitude),
//                    zoomLevel: 10,
//                    mapView: mapView!
//                )
//                mapView?.moveCamera(cameraUpdate)
//                first = false
//            }
        }
    }
}
