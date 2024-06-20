import ProjectDescription

let project = Project(
    name: "SearchFeature",
    targets: [
        .target(
            name: "SearchFeature",
            destinations: .iOS,
            product: .framework,
            bundleId: "io.justios.SearchFeature",
            deploymentTargets: .iOS("16.0"),
            sources: ["Sources/**"],
            dependencies: []
        )
    ]
)
