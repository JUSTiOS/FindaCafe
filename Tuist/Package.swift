// swift-tools-version: 5.9
import PackageDescription

#if TUIST
import ProjectDescription

let packageSettings = PackageSettings(
    productTypes: [
        "Alamofire": .staticLibrary,
        "KakaoMapsSDK-SPM": .staticLibrary
    ]
)
#endif

let package = Package(
    name: "FindaCafe",
    dependencies: [
        .package(url: "https://github.com/Alamofire/Alamofire.git", from: "5.9.0"),
        .package(url: "https://github.com/kakao-mapsSDK/KakaoMapsSDK-SPM.git", from: "2.10.0")
    ]
)
