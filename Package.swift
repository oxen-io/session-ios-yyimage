// swift-tools-version:5.7
import PackageDescription

let package = Package(
    name: "YYImage",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        .library(
            name: "YYImage",
            targets: ["YYImageCore", "YYImageWebP", "YYImageLibwebp"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/SDWebImage/libwebp-Xcode", from: "1.3.2")
    ],
    targets: [
        .target(
            name: "YYImageCore",
            path: "YYImage",
            publicHeadersPath: ".",
            sources: ["*.h", "*.m"],
            cSettings: [
                .headerSearchPath("$(SRCROOT)/libwebp/src")
            ],
            linkerSettings: [
                .linkedLibrary("z"),
                .linkedFramework("UIKit"),
                .linkedFramework("CoreFoundation"),
                .linkedFramework("QuartzCore"),
                .linkedFramework("AssetsLibrary"),
                .linkedFramework("ImageIO"),
                .linkedFramework("Accelerate"),
                .linkedFramework("CoreServices/CoreServices")
            ]
        ),
        .target(
            name: "YYImageWebP",
            dependencies: ["YYImageCore"],
            path: "Vendor",
            publicHeadersPath: ".",
            sources: ["WebP.framework"]
        ),
        .target(
            name: "YYImageLibwebp",
            dependencies: ["YYImageCore", "libwebp"],
            path: "libwebp",
            publicHeadersPath: ".",
            sources: ["src/*.h", "src/*.c"],
            cSettings: [
                .headerSearchPath("$(SRCROOT)/libwebp/src")
            ]
        )
    ]
)