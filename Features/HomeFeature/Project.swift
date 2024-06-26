import ProjectDescription

let project = Project(
    name: "HomeFeature",
    targets: [
        .target(
            name: "HomeFeature",
            destinations: .iOS,
            product: .framework,
            bundleId: "io.justios.HomeFeature",
            deploymentTargets: .iOS("15.0"),
            sources: ["Sources/**"],
            dependencies: []
        )
    ]
)
