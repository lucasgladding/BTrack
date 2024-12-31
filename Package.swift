// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "BTrack",
    products: [
        .library(
            name: "BTrack",
            targets: ["BTrack"]),
    ],
    targets: [
        .systemLibrary(
            name: "Clibsamplerate",
            pkgConfig: "samplerate",
            providers: [
                .brew(["libsamplerate"]),
            ]
        ),
        .target(
            name: "kiss_fft",
            path: "libs/kiss_fft130",
            publicHeadersPath: "."
        ),
        .target(
            name: "BTrack",
            dependencies: ["Clibsamplerate", "kiss_fft"],
            path: "src",
            exclude: [
                "CMakeLists.txt",
            ],
            publicHeadersPath: ".",
            cSettings: [
                .headerSearchPath("."),
                .headerSearchPath("opt/homebrew/include"),
                .define("USE_KISS_FFT"),
            ]
        ),
        .testTarget(
            name: "BTrackTests",
            dependencies: ["BTrack", "kiss_fft"],
            path: "tests",
            exclude: [
                "CMakeLists.txt"
            ],
            sources: [
                "main.cpp",
                "Test_BTrack.cpp"
            ],
            cSettings: [
                .headerSearchPath("./doctest"),
                .headerSearchPath("../src"),
            ]
        ),
    ],
    cxxLanguageStandard: .cxx17
)
