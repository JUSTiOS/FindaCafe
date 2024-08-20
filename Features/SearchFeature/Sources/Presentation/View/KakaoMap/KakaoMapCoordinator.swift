import SwiftUI
import KakaoMapsSDK
import CommonUI

class KakaoMapCoordinator: NSObject, MapControllerDelegate, ObservableObject {
    var myLocation: MyLocationEntity?
    var nearbyCafes: [NearbyCafeEntity]
    var selectedCafe: NearbyCafeEntity
    
    override init() {
        selectedCafe = NearbyCafeEntity(
            cafeName: "-",
            phone: "-",
            distance: "-",
            latitude: "-",
            longitude: "-",
            categoryName: "-",
            address: "-"
        )
        nearbyCafes = []
        super.init()
    }
    
    func viewInit(viewName: String) {
        createSpriteGUI()
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
        if let centerOfMap = myLocation {
            let defaultPosition: MapPoint = MapPoint(longitude: centerOfMap.longitude, latitude: centerOfMap.latitude)
            let mapviewInfo: MapviewInfo = MapviewInfo(viewName: "mapview", viewInfoName: "map", defaultPosition: defaultPosition, defaultLevel: 15)
            controller?.addView(mapviewInfo)
        } else {
            let defaultPosition: MapPoint = MapPoint(longitude: Double(nearbyCafes[0].longitude) ?? 0.0, latitude: Double(nearbyCafes[0].latitude) ?? 0.0)
            let mapviewInfo: MapviewInfo = MapviewInfo(viewName: "mapview", viewInfoName: "map", defaultPosition: defaultPosition, defaultLevel: 17)
            controller?.addView(mapviewInfo)
        }
    }
    
    func createSpriteGUI() {
        let view = controller?.getView("mapview") as! KakaoMap
        
        view.setLogoPosition(origin: GuiAlignment(vAlign: .bottom, hAlign: .right), position: CGPoint(x: 10.0, y: 60.0))
        
        view.setCompassPosition(origin: GuiAlignment(vAlign: .bottom, hAlign: .left), position: CGPoint(x: 10.0, y: 40.0))
        view.showCompass()
        
        view.setScaleBarPosition(origin: GuiAlignment(vAlign: .bottom, hAlign: .right), position: CGPoint(x: 10.0, y: 40.0))
        
        view.showScaleBar()
    }
    
    func addViewSucceeded(_ viewName: String, viewInfoName: String) {
        let view = controller?.getView("mapview")
        view?.viewRect = container!.bounds
        
        viewInit(viewName: viewName)
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
        let iconStyle = PoiIconStyle(symbol: CommonUIAsset.myLocation.image, anchorPoint: CGPoint(x: 0.5, y: 0.5))
        let text = PoiTextLineStyle(textStyle: TextStyle(fontSize: 25, fontColor: UIColor.systemRed, strokeThickness: 5, strokeColor: .white))
        let textStyle = PoiTextStyle(textLineStyles: [text])
        textStyle.textLayouts = [PoiTextLayout.bottom]
        
        let poiStyle = PoiStyle(styleID: "myLocationPoiStyle", styles: [
            PerLevelPoiStyle(iconStyle: iconStyle, textStyle: textStyle, level: 0)
        ])
        
        manager.addPoiStyle(poiStyle)
    }
    
    func createNearbyCafePoiStyle() {
        let view = controller?.getView("mapview") as! KakaoMap
        let manager = view.getLabelManager()
        let iconStyle = PoiIconStyle(symbol: CommonUIAsset.mapCafepoi.image, anchorPoint: CGPoint(x: 0.5, y: 0.5))
        let text = PoiTextLineStyle(textStyle: TextStyle(fontSize: 25, fontColor: UIColor.black, strokeThickness: 2, strokeColor: .white))
        let textStyle = PoiTextStyle(textLineStyles: [text])
        textStyle.textLayouts = [PoiTextLayout.bottom]
        let poiStyle = PoiStyle(styleID: "nearbyCafePoiStyle", styles: [
            PerLevelPoiStyle(iconStyle: iconStyle, textStyle: textStyle, level: 0)
        ])
        manager.addPoiStyle(poiStyle)
    }
    
    func createMyLocationPois() {
        if let myLocation = myLocation {
            let view = controller?.getView("mapview") as! KakaoMap
            let manager = view.getLabelManager()
            let layer = manager.getLabelLayer(layerID: "PoiLayer")
            let poiOption = PoiOptions(styleID: "myLocationPoiStyle")
            poiOption.rank = 0
            poiOption.clickable = true
            poiOption.addText(PoiText(text: "현위치", styleIndex: 0))
            
            let poi1 = layer?.addPoi(option: poiOption, at: MapPoint(longitude: myLocation.longitude, latitude: myLocation.latitude), callback: {(_ poi: (Poi?)) -> Void in
                print("")
            }
            )
            poi1?.show()
        }
    }
    
    func createNearbyCafePois(nearbyCafe: NearbyCafeEntity) {
        let view = controller?.getView("mapview") as! KakaoMap
        let manager = view.getLabelManager()
        let layer = manager.getLabelLayer(layerID: "PoiLayer")
        let poiOption = PoiOptions(styleID: "nearbyCafePoiStyle")
        poiOption.rank = 0
        poiOption.clickable = true
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
        if let myLocation = myLocation {
            let mapView = controller?.getView("mapview") as! KakaoMap
            let cameraUpdate: CameraUpdate = CameraUpdate.make(target: MapPoint(longitude: myLocation.longitude, latitude: myLocation.latitude), zoomLevel: 15, mapView: mapView)
            mapView.animateCamera(cameraUpdate: cameraUpdate, options: CameraAnimationOptions(autoElevation: false, consecutive: false, durationInMillis: 0))
        }
    }
    
    func containerDidResized(_ size: CGSize) {
        let mapView: KakaoMap = controller?.getView("mapview") as! KakaoMap
        mapView.viewRect = CGRect(origin: CGPoint(x: 0.0, y: 0.0), size: size)
        
        if let latitude = Double(selectedCafe.latitude) {
            let longitude = Double(selectedCafe.longitude) ?? 0.0
            let cameraUpdate: CameraUpdate = CameraUpdate.make(target: MapPoint(longitude: longitude, latitude: latitude), zoomLevel: 17, mapView: mapView)
            mapView.animateCamera(cameraUpdate: cameraUpdate, options: CameraAnimationOptions(autoElevation: false, consecutive: false, durationInMillis: 0))
        }
    }
    
    var controller: KMController?
    var container: KMViewContainer?
    @State var resize: Bool = false
}
