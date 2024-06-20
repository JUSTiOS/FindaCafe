import SwiftUI
import KakaoMapsSDK

struct KakaoMapView: UIViewRepresentable {
    var draw: Bool
    
    var latitude: Double
    var longitude: Double
    
    func makeUIView(context: Self.Context) -> KMViewContainer {
        let view: KMViewContainer = KMViewContainer(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        context.coordinator.createController(view)
        return view
    }
    
    func updateUIView(_ uiView: KMViewContainer, context: Self.Context) {
        if draw {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                if context.coordinator.controller?.isEnginePrepared == false {
                    context.coordinator.controller?.prepareEngine()
                }
                
                if context.coordinator.controller?.isEngineActive == false {
                    context.coordinator.controller?.activateEngine()
                }
            }
        }
        else {
            context.coordinator.controller?.pauseEngine()
            context.coordinator.controller?.resetEngine()
        }
    }
    
    func makeCoordinator() -> KakaoMapCoordinator {
        let coordinator = KakaoMapCoordinator()
        coordinator.latitude = latitude
        coordinator.longitude = longitude
        print("kako location -> ", coordinator.latitude, coordinator.longitude)
        return coordinator
    }
    
    class KakaoMapCoordinator: NSObject, MapControllerDelegate {
        var latitude: Double
        var longitude: Double
        
        override init() {
            first = true
            auth = false
            latitude = 0.0
            longitude = 0.0
            super.init()
        }
        
        func viewInit(viewName: String) {
            createLabelLayer()
            createPoiStyle()
            createPois()
        }
        
        func createController(_ view: KMViewContainer) {
            container = view
            controller = KMController(viewContainer: view)
            controller?.delegate = self
        }
        
        func addViews() {
            let defaultPosition: MapPoint = MapPoint(longitude: longitude, latitude: latitude)
            let mapviewInfo: MapviewInfo = MapviewInfo(viewName: "mapview", viewInfoName: "map", defaultPosition: defaultPosition)
            
            controller?.addView(mapviewInfo)
        }
        
        func addViewSucceeded(_ viewName: String, viewInfoName: String) {
            let view = controller?.getView("mapview")
            view?.viewRect = container!.bounds
            viewInit(viewName: viewName)
        }
        
        func containerDidResized(_ size: CGSize) {
            let mapView: KakaoMap? = controller?.getView("mapview") as? KakaoMap
            mapView?.viewRect = CGRect(origin: CGPoint(x: 0.0, y: 0.0), size: size)
            
            if first {
                let cameraUpdate: CameraUpdate = CameraUpdate.make(target: MapPoint(longitude: longitude, latitude: latitude), mapView: mapView!)
                mapView?.moveCamera(cameraUpdate)
                first = false
            }
        }
        
        func authenticationSucceeded() {
            auth = true
        }
        
        func createLabelLayer() {
            let view = controller?.getView("mapview") as! KakaoMap
            let manager = view.getLabelManager()
            let layerOption = LabelLayerOptions(layerID: "PoiLayer", competitionType: .none, competitionUnit: .symbolFirst, orderType: .rank, zOrder: 0)
            let _ = manager.addLabelLayer(option: layerOption)
        }
        
        func createPoiStyle() {
            let view = controller?.getView("mapview") as! KakaoMap
            let manager = view.getLabelManager()
            // 심볼을 지정.
            // 심볼의 anchor point(심볼이 배치될때의 위치 기준점)를 지정. 심볼의 좌상단을 기준으로 한 % 값.
            let config =  UIImage.SymbolConfiguration(hierarchicalColor: .systemRed)
            let image = UIImage(systemName: "record.circle.fill", withConfiguration: config)
            let iconStyle = PoiIconStyle(symbol: image, anchorPoint: CGPoint(x: 0.5, y: 0.5))
            let text = PoiTextLineStyle(textStyle: TextStyle(fontSize: 25, fontColor: UIColor.systemRed))
            let textStyle = PoiTextStyle(textLineStyles: [text])
            textStyle.textLayouts = [PoiTextLayout.bottom, PoiTextLayout.center] // 이 스타일이 적용되기 시작할 레벨.
            let poiStyle = PoiStyle(styleID: "customStyle1", styles: [
                PerLevelPoiStyle(iconStyle: iconStyle, textStyle: textStyle, level: 0)
            ])
            manager.addPoiStyle(poiStyle)
        }
        
        func createPois() {
            let view = controller?.getView("mapview") as! KakaoMap
            let manager = view.getLabelManager()
            let layer = manager.getLabelLayer(layerID: "PoiLayer")   // 생성한 POI를 추가할 레이어를 가져온다.
            let poiOption = PoiOptions(styleID: "customStyle1") // 생성할 POI의 Option을 지정하기 위한 자료를 담는 클래스를 생성. 사용할 스타일의 ID를 지정한다.
            poiOption.rank = 0
            poiOption.clickable = true // clickable 옵션을 true로 설정한다. default는 false로 설정되어있다.
            poiOption.addText(PoiText(text: "현위치", styleIndex: 0))
            
            let poi1 = layer?.addPoi(option: poiOption, at: MapPoint(longitude:longitude, latitude: latitude), callback: {(_ poi: (Poi?)) -> Void in
                print("")
            }
            )
            poi1?.show()
        }
        
        var controller: KMController?
        var container: KMViewContainer?
        var first: Bool
        var auth: Bool
    }
}
