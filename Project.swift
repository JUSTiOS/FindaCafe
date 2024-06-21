import ProjectDescription

let project = Project(
    name: "FindaCafe",
    targets: [
        .target(
            name: "FindaCafe",
            destinations: .iOS,
            product: .app,
            bundleId: "io.justios.FindaCafe",
            deploymentTargets: .iOS("16.0"),
            infoPlist: .extendingDefault(
                with: [
                    "NSLocationWhenInUseUsageDescription": "This app can track your location for find near cafe",
                    "UILaunchStoryboardName": "LaunchScreen.storyboard",
                ]
            ),
            sources: ["FindaCafe/Sources/**"],
            dependencies: [
                .project(target: "HomeFeature", path: .relativeToRoot("Features/HomeFeature")),
                .project(target: "SearchFeature", path: .relativeToRoot("Features/SearchFeature")),
                
            ]
        ),
        .target(
            name: "FindaCafeTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "io.justios.FindaCafeTests",
            deploymentTargets: .iOS("16.0"),
            infoPlist: .default,
            sources: ["FindaCafe/Tests/**"],
            resources: [],
            dependencies: [.target(name: "FindaCafe")]
        ),
    ]
)
