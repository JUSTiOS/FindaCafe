import ProjectDescription

let targets: [Target] = [
    .target(
        name: "HomeFeature",
        destinations: .iOS,
        product: .staticFramework,
        bundleId: "io.justios.HomeFeature",
        deploymentTargets: .iOS("16.0"),
        sources: ["Sources/**"],
        resources: ["Resources/**"],
        dependencies: [
            .external(name: "Alamofire"),
            .external(name: "KakaoMapsSDK-SPM")
        ],
        settings: .settings(base: ["OTHER_LDFLAGS": "-ObjC"]),
        coreDataModels: [
            .coreDataModel("Sources/Data/PersistentStorage/CoreDataStorage/Cafe.xcdatamodeld")
        ]
    ),
    .target(
        name: "HomeFeatureTests",
        destinations: .iOS,
        product: .unitTests,
        bundleId: "io.justios.HomeFeatureTests",
        deploymentTargets: .iOS("16.0"),
        sources: ["Tests/**"],
        dependencies: [
            .target(name: "HomeFeature")
        ]
    )
]

let project = Project(
    name: "HomeFeature",
    targets: targets
)
