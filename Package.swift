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
            name: "BTrack",
            dependencies: ["Clibsamplerate"],
            path: "src",
            sources: [
                "Btrack.cpp",
                "Btrack.h",
                "OnsetDetectionFunction.cpp",
                "OnsetDetectionFunction.h",
                "CircularBuffer.h",
            ],
            publicHeadersPath: ".",
            cxxSettings: [
                .headerSearchPath("."),
                .headerSearchPath("../libs/kiss_fft130"),
                .headerSearchPath("opt/homebrew/include"),
                .define("USE_KISS_FFT"),
            ]
        ),
        .testTarget(
            name: "BTrackTests",
            dependencies: ["BTrack"],
            path: "tests",
            sources: [
                "main.cpp",
                "../libs/kiss_fft130/kiss_fft.c",
                "Test_BTrack.cpp",
            ],
            cxxSettings: [
                .headerSearchPath("./doctest"),
                .headerSearchPath("../src"),
                .headerSearchPath("../libs/kiss_fft130"),
            ]
        ),
    ],
    cxxLanguageStandard: .cxx17
)
