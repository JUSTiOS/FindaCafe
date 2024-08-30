import ProjectDescription

let targets: [Target] = [
    .target(
        name: "InfoFeature",
        destinations: .iOS,
        product: .staticFramework,
        bundleId: "io.justios.InfoFeature",
        deploymentTargets: .iOS("16.0"),
        sources: ["Sources/**"],
        settings: .settings(base: ["OTHER_LDFLAGS": "-ObjC"])
    )
]

let project = Project(
    name: "InfoFeature",
    targets: targets
)
