import ProjectDescription

let project = Project(
    name: "FindaCafe",
    targets: [
        .target(
            name: "FindaCafe",
            destinations: .iOS,
            product: .app,
            bundleId: "io.juistios.FindaCafe",
            deploymentTargets: .iOS("16.0"),
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchStoryboardName": "LaunchScreen.storyboard",
                ]
            ),
            sources: ["FindaCafe/Sources/**"],
            resources: ["FindaCafe/Resources/**"],
            dependencies: [
                .project(target: "HomeFeature", path: "Features/HomeFeature"),
                .project(target: "SearchFeature", path: "Features/SearchFeature"),
                .external(name: "KakaoMapsSDK-SPM")
            ]
        ),
        .target(
            name: "FindaCafeTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "io.juistios.FindaCafeTests",
            deploymentTargets: .iOS("16.0"),
            infoPlist: .default,
            sources: ["FindaCafe/Tests/**"],
            resources: [],
            dependencies: [.target(name: "FindaCafe")]
        ),
    ]
)
