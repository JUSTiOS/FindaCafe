import ProjectDescription

let targets: [Target] = [
    .target(
        name: "SearchFeature",
        destinations: .iOS,
        product: .staticFramework,
        bundleId: "io.justios.SearchFeature",
        deploymentTargets: .iOS("16.0"),
        sources: ["Sources/**"],
        dependencies: [
            .external(name: "Alamofire"),
            .external(name: "KakaoMapsSDK-SPM")
        ],
        settings: .settings(base: ["OTHER_LDFLAGS": "-ObjC"]),
        coreDataModels: [
            .coreDataModel("Sources/Data/CafeCoreData.xcdatamodeld")
        ]
    )
]

let project = Project(
    name: "SearchFeature",
    targets: targets
)
