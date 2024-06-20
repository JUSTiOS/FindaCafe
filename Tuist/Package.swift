// swift-tools-version: 5.9
import PackageDescription

#if TUIST
    import ProjectDescription

    let packageSettings = PackageSettings(
        // Customize the product types for specific package product
        // Default is .staticFramework
        // productTypes: ["Alamofire": .framework,]
        productTypes: ["Alamofire": .staticLibrary, "KakaoMapsSDK-SPM": .staticLibrary]
    )
#endif

let package = Package(
    name: "FindaCafe",
    dependencies: [
        // Add your own dependencies here:
        // .package(url: "https://github.com/Alamofire/Alamofire", from: "5.0.0"),
        // You can read more about dependencies here: https://docs.tuist.io/documentation/tuist/dependencies
        .package(url: "https://github.com/Alamofire/Alamofire", from: "5.9.1"),
        .package(url: "https://github.com/kakao-mapsSDK/KakaoMapsSDK-SPM", from: "2.10.5")
    ]
)
