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
            name: "libsamplerate",
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
            dependencies: ["libsamplerate", "kiss_fft"],
            path: "src",
            sources: [
                "BTrack.cpp",
                "BTrack.h",
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
        .executableTarget(
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
        )
    ],
    cxxLanguageStandard: .cxx17
)
