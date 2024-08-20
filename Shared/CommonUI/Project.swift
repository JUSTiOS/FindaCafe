import ProjectDescription

let targets: [Target] = [
    .target(
        name: "CommonUI",
        destinations: .iOS,
        product: .staticFramework,
        bundleId: "io.justios.CommonUI",
        deploymentTargets: .iOS("16.0"),
        resources: ["Resources/**"],
        settings: .settings(base: ["OTHER_LDFLAGS": "-ObjC"])
    )
]

let project = Project(
    name: "CommonUI",
    targets: targets
)
