import ProjectDescription

let project = Project(name: "SearchFeature",
                      targets: [
                        .target(name: "SearchFeature",
                                destinations: .iOS,
                                product: .framework,
                                bundleId: "io.justios.SearchFeature",
                                sources: ["Sources/**"],
                                dependencies: []
                               )
                      ]
)
