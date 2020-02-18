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
    dependencies: [],
    targets: [
        .target(
            name: "DictionarySorting",
            dependencies: []),
        .testTarget(
            name: "DictionarySortingTests",
            dependencies: ["DictionarySorting"]),
    ]
)
