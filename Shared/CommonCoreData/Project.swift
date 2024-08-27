import ProjectDescription

let targets: [Target] = [
    .target(
        name: "CommonCoreData",
        destinations: .iOS,
        product: .staticFramework,
        bundleId: "io.justios.CommonCoreData",
        deploymentTargets: .iOS("16.0"),
        sources: ["Sources/**"],
        settings: .settings(base: ["OTHER_LDFLAGS": "-ObjC"]),
        coreDataModels: [
            .coreDataModel("Sources/CafeData.xcdatamodeld")
        ]
    )
]

let project = Project(
    name: "CommonCoreData",
    targets: targets
)
