// swift-tools-version:5.7
import PackageDescription

let package = Package(
    name: "YYImage",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v12)
    ],
    products: [
        .library(
            name: "YYImage",
            targets: ["YYImage"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/SDWebImage/libwebp-Xcode", from: "1.3.2")
    ],
    targets: [
        .target(
            name: "YYImage",
            dependencies: [
                .product(name: "libwebp", package: "libwebp-Xcode")
            ],
            path: ".",
            sources: ["YYImage"],
            publicHeadersPath: "YYImage"
        )
    ]
)