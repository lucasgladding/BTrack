// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Btrack",
    products: [
        .library(
            name: "Btrack",
            targets: ["Btrack"]),
    ],
    targets: [
        .systemLibrary(
            name: "libsamplerate",
            pkgConfig: "libsamplerate",
            providers: [
                .brew(["libsamplerate"]),
            ]
        ),
        .target(
            name: "Btrack",
            dependencies: ["libsamplerate"],
            path: "src",
            exclude: [
                "CMakeLists.txt",
            ],
            publicHeadersPath: ".",
            cSettings: [
                .headerSearchPath("."),
                .headerSearchPath("../libs/kiss_fft130"),
                .headerSearchPath("opt/homebrew/include"),
                .define("USE_KISS_FFT"),
            ]
        ),
        .testTarget(
            name: "BtrackTests",
            dependencies: ["Btrack"],
            path: "tests",
            exclude: [
                "CMakeLists.txt"
            ]
        ),
    ]
)
