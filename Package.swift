// swift-tools-version: 5.8

// Package.swift
// Swift Package Manager manifest file
import PackageDescription

let package = Package(
    name: "dextra",
    products: [
        .executable(name: "dextra", targets: ["dextra"]),
        .library(name: "ConsoleLib", targets: ["ConsoleLib"])
    ],
    dependencies: [],
    targets: [
        .target(
            name: "ConsoleLib",
            dependencies: ["curses"],
            linkerSettings: [
                .linkedLibrary("ncurses")
            ]
        ),
        .executableTarget(
            name: "dextra",
            dependencies: ["ConsoleLib", "curses"],
            linkerSettings: [
                .linkedLibrary("ncurses")
            ]
        ),
        .systemLibrary(
            name: "curses",
            path: "Sources/curses"
        )
    ]
)
