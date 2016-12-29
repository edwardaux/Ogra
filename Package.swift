import PackageDescription

let package = Package(
    name: "Ogra",
    targets: [
        Target(name: "Ogra")
    ],
    dependencies: [
        .Package(url: "https://github.com/thoughtbot/Argo.git", majorVersion: 4)
    ]
)
