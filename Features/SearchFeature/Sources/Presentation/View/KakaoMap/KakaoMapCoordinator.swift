import SwiftUI
import KakaoMapsSDK

class KakaoMapCoordinator: NSObject, MapControllerDelegate, ObservableObject {
    var myLocation: MyLocationEntity
    var nearbyCafes: [NearbyCafeEntity]
    
    override init() {
        first = true
        auth = false
        myLocation = MyLocationEntity(latitude: 0.0, longitude: 0.0)
        nearbyCafes = []
        super.init()
    }
    
    func viewInit(viewName: String) {
        createLabelLayer()
        createMyLocationPoiStyle()
        createMyLocationPois()
        
        for nearbyCafe in nearbyCafes {
            createNearbyCafePoiStyle()
            createNearbyCafePois(nearbyCafe: nearbyCafe)
        }
    }
    
    func createController(_ view: KMViewContainer) {
        container = view
        controller = KMController(viewContainer: view)
        controller?.delegate = self
    }
    
    func addViews() {
        let defaultPosition: MapPoint = MapPoint(longitude: myLocation.longitude, latitude: myLocation.latitude)
        let mapviewInfo: MapviewInfo = MapviewInfo(viewName: "mapview", viewInfoName: "map", defaultPosition: defaultPosition, defaultLevel: 15)
        
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
            let cameraUpdate: CameraUpdate = CameraUpdate.make(target: MapPoint(longitude: myLocation.longitude, latitude: myLocation.latitude), mapView: mapView!)
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
        let layerOption = LabelLayerOptions(layerID: "PoiLayer", competitionType: .none, competitionUnit: .symbolFirst, orderType: .rank, zOrder: 100000)
        let _ = manager.addLabelLayer(option: layerOption)
    }
    
    func createMyLocationPoiStyle() {
        let view = controller?.getView("mapview") as! KakaoMap
        let manager = view.getLabelManager()
        let config =  UIImage.SymbolConfiguration(hierarchicalColor: .systemRed)
        let image = UIImage(systemName: "record.circle.fill", withConfiguration: config)
        let iconStyle = PoiIconStyle(symbol: image, anchorPoint: CGPoint(x: 0.5, y: 0.5))
        let text = PoiTextLineStyle(textStyle: TextStyle(fontSize: 25, fontColor: UIColor.systemRed, strokeThickness: 5, strokeColor: .white))
        let textStyle = PoiTextStyle(textLineStyles: [text])
        textStyle.textLayouts = [PoiTextLayout.bottom, PoiTextLayout.center] // 이 스타일이 적용되기 시작할 레벨.
        let poiStyle = PoiStyle(styleID: "myLocationPoiStyle", styles: [
            PerLevelPoiStyle(iconStyle: iconStyle, textStyle: textStyle, level: 0)
        ])
        manager.addPoiStyle(poiStyle)
    }
    
    func createNearbyCafePoiStyle() {
        let view = controller?.getView("mapview") as! KakaoMap
        let manager = view.getLabelManager()
        let image = UIImage(named: "cafepoi")
        let iconStyle = PoiIconStyle(symbol: image, anchorPoint: CGPoint(x: 0.5, y: 0.5))
        let text = PoiTextLineStyle(textStyle: TextStyle(fontSize: 25, fontColor: UIColor.orange, strokeThickness: 5, strokeColor: .white))
        let textStyle = PoiTextStyle(textLineStyles: [text])
        textStyle.textLayouts = [PoiTextLayout.bottom, PoiTextLayout.center] // 이 스타일이 적용되기 시작할 레벨.
        let poiStyle = PoiStyle(styleID: "nearbyCafePoiStyle", styles: [
            PerLevelPoiStyle(iconStyle: iconStyle, textStyle: textStyle, level: 0)
        ])
        manager.addPoiStyle(poiStyle)
    }
    
    func createMyLocationPois() {
        let view = controller?.getView("mapview") as! KakaoMap
        let manager = view.getLabelManager()
        let layer = manager.getLabelLayer(layerID: "PoiLayer")   // 생성한 POI를 추가할 레이어를 가져온다.
        let poiOption = PoiOptions(styleID: "myLocationPoiStyle") // 생성할 POI의 Option을 지정하기 위한 자료를 담는 클래스를 생성. 사용할 스타일의 ID를 지정한다.
        poiOption.rank = 0
        poiOption.clickable = true // clickable 옵션을 true로 설정한다. default는 false로 설정되어있다.
        poiOption.addText(PoiText(text: "현위치", styleIndex: 0))
        
        let poi1 = layer?.addPoi(option: poiOption, at: MapPoint(longitude: myLocation.longitude, latitude: myLocation.latitude), callback: {(_ poi: (Poi?)) -> Void in
            print("")
        }
        )
        poi1?.show()
    }
    
    func createNearbyCafePois(nearbyCafe: NearbyCafeEntity) {
        let view = controller?.getView("mapview") as! KakaoMap
        let manager = view.getLabelManager()
        let layer = manager.getLabelLayer(layerID: "PoiLayer")   // 생성한 POI를 추가할 레이어를 가져온다.
        let poiOption = PoiOptions(styleID: "nearbyCafePoiStyle") // 생성할 POI의 Option을 지정하기 위한 자료를 담는 클래스를 생성. 사용할 스타일의 ID를 지정한다.
        poiOption.rank = 0
        poiOption.clickable = true // clickable 옵션을 true로 설정한다. default는 false로 설정되어있다.
        poiOption.addText(PoiText(text: nearbyCafe.cafeName, styleIndex: 0))
        
        let longitude = Double(nearbyCafe.longitude) ?? 0.0
        let latitude = Double(nearbyCafe.latitude) ?? 0.0
        
        let poi1 = layer?.addPoi(option: poiOption, at: MapPoint(longitude: longitude, latitude: latitude), callback: {(_ poi: (Poi?)) -> Void in
            print("")
        }
        )
        poi1?.show()
    }
    
    func moveCamera() {
        let mapView = controller?.getView("mapview") as! KakaoMap
        let cameraUpdate: CameraUpdate = CameraUpdate.make(target: MapPoint(longitude: myLocation.longitude, latitude: myLocation.latitude), zoomLevel: 15, mapView: mapView)
        mapView.animateCamera(cameraUpdate: cameraUpdate, options: CameraAnimationOptions(autoElevation: true, consecutive: false, durationInMillis: 300))
    }
    
    var controller: KMController?
    var container: KMViewContainer?
    var first: Bool
    var auth: Bool
}
