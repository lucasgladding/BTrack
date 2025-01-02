// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "BTrackKit",
    products: [
        .library(
            name: "BTrackKit",
            targets: ["BTrackKit"]
        ),
    ],
    targets: [
        .target(
            name: "kiss_fft",
            path: "libs/kiss_fft130",
            publicHeadersPath: "."
        ),
        .systemLibrary(
            name: "libsamplerate",
            pkgConfig: "samplerate"
        ),
        .target(
            name: "BTrackKit",
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
                .headerSearchPath("usr/local/include"),
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
