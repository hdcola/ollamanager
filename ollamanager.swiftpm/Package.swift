// swift-tools-version: 5.8

// WARNING:
// This file is automatically generated.
// Do not edit it by hand because the contents will be replaced.

import PackageDescription
import AppleProductTypes

let package = Package(
    name: "ollamanager",
    platforms: [
        .iOS("16.0")
    ],
    products: [
        .iOSApplication(
            name: "ollamanager",
            targets: ["AppModule"],
            bundleIdentifier: "sicheng.hdcola.one.ollamanager",
            displayVersion: "1.0",
            bundleVersion: "1",
            appIcon: .placeholder(icon: .tv),
            accentColor: .presetColor(.blue),
            supportedDeviceFamilies: [
                .pad,
                .phone
            ],
            supportedInterfaceOrientations: [
                .portrait,
                .landscapeRight,
                .landscapeLeft,
                .portraitUpsideDown(.when(deviceFamilies: [.pad]))
            ],
            capabilities: [
                .incomingNetworkConnections(),
                .outgoingNetworkConnections()
            ]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/kevinhermawan/OllamaKit.git", "3.0.2"..<"4.0.0")
    ],
    targets: [
        .executableTarget(
            name: "AppModule",
            dependencies: [
                .product(name: "OllamaKit", package: "ollamakit")
            ],
            path: "."
        )
    ]
)