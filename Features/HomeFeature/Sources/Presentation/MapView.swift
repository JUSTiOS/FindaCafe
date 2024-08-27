//
//  MapView.swift
//  HomeFeature
//
//  Created by Jaehun Lee on 6/10/24.
//

import SwiftUI
import KakaoMapsSDK
import CommonUI

struct MapView: UIViewRepresentable {
    private let size: CGSize
    private let cafe: Cafe
    
    init(size: CGSize, cafe: Cafe) {
        self.size = size
        self.cafe = cafe
        
        // TODO: - Info.plist에서 안전하게 불러오는 코드 추가 작성 필요
        SDKInitializer.InitSDK(appKey: Bundle.main.infoDictionary?["AUTH_API_KEY"] as! String)
    }
    
    func makeUIView(context: Self.Context) -> KMViewContainer {
        let view: KMViewContainer = KMViewContainer(frame: .init(origin: .zero, size: size))
        view.sizeToFit()
        context.coordinator.createController(view)
        context.coordinator.controller?.prepareEngine()
        
        return view
    }

    func updateUIView(_ uiView: KMViewContainer, context: Self.Context) {
        context.coordinator.controller?.activateEngine()
    }
    
    func makeCoordinator() -> KakaoMapCoordinator {
        return KakaoMapCoordinator(cafe: cafe)
    }
    
    static func dismantleUIView(_ uiView: KMViewContainer, coordinator: KakaoMapCoordinator) {
        coordinator.controller?.pauseEngine()
        coordinator.controller?.resetEngine()
    }
    
    class KakaoMapCoordinator: NSObject, MapControllerDelegate {
        var controller: KMController?
        private var first: Bool
        private let cafeName: String
        private let cafePosition: MapPoint
        
        init(cafe: Cafe) {
            first = true
            self.cafeName = cafe.name
            self.cafePosition = MapPoint(longitude: cafe.coord.longitude, latitude: cafe.coord.latitude)
            super.init()
        }
        
        func createController(_ view: KMViewContainer) {
            controller = KMController(viewContainer: view)
            controller?.delegate = self
        }
        
        func addViews() {
            let mapviewInfo: MapviewInfo = MapviewInfo(viewName: "mapview", viewInfoName: "map", defaultPosition: cafePosition)
            
            controller?.addView(mapviewInfo)
        }

        func addViewSucceeded(_ viewName: String, viewInfoName: String) {
            let view = controller?.getView(viewName) as! KakaoMap
            createLabelLayer(for: view)
            createPoiStyle(for: view)
            createPoi(for: view)
        }
        
        private func createLabelLayer(for view: KakaoMap) {
            let labelManager = view.getLabelManager()
            let layerOption = LabelLayerOptions(
                layerID: "PoiLayer",
                competitionType: .same,
                competitionUnit: .symbolFirst,
                orderType: .rank,
                zOrder: 0
            )
            _ = labelManager.addLabelLayer(option: layerOption)
        }
        
        private func createPoiStyle(for view: KakaoMap) {
            let labelManager = view.getLabelManager()
            let iconStyle = PoiIconStyle(symbol: CommonUIAsset.mapCafepoi.image, anchorPoint: CGPoint(x: 0.5, y: 1))
            let textStyle = TextStyle(fontSize: 25, fontColor: .black, strokeThickness: 2, strokeColor: .white)
            let poiTextStyle = PoiTextStyle(textLineStyles: [PoiTextLineStyle(textStyle: textStyle)])
            
            let poiStyle = PoiStyle(styleID: "PerLevelPoiStyle", styles: [PerLevelPoiStyle(iconStyle: iconStyle, textStyle: poiTextStyle)])
            
            labelManager.addPoiStyle(poiStyle)
        }
        
        private func createPoi(for view: KakaoMap) {
            let labelManager = view.getLabelManager()
            let layer = labelManager.getLabelLayer(layerID: "PoiLayer")
            let poiOption = PoiOptions(styleID: "PerLevelPoiStyle")
            poiOption.rank = 0
            poiOption.addText(PoiText(text: cafeName, styleIndex: 0))
            
            let poi = layer?.addPoi(option: poiOption, at: cafePosition)
            poi?.show()
        }
        
        func addViewFailed(_ viewName: String, viewInfoName: String) {
            print("Failed")
        }
        
        func containerDidResized(_ size: CGSize) {
            let mapView: KakaoMap? = controller?.getView("mapview") as? KakaoMap
            mapView?.viewRect = CGRect(origin: .zero, size: size)
        }
    }
}
