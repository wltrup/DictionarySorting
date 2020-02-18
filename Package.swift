// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DictionarySorting",
    products: [
        .library(
            name: "DictionarySorting",
            targets: ["DictionarySorting"]),
    ],
    dependencies: [
        .package(url: "https://github.com/wltrup/SortOrder.git", from: "0.1.0"),
        .package(url: "https://github.com/wltrup/DictionarySlicing.git", from: "0.1.0"),
    ],
    targets: [
        .target(
            name: "DictionarySorting",
            dependencies: [
                "SortOrder",
                "DictionarySlicing",
            ]
        ),
        .testTarget(
            name: "DictionarySortingTests",
            dependencies: ["DictionarySorting"]
        ),
    ]
)
