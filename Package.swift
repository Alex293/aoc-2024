// swift-tools-version: 6.0
import PackageDescription

let dependencies: [Target.Dependency] = [
  .product(name: "Algorithms", package: "swift-algorithms"),
  .product(name: "Collections", package: "swift-collections"),
]

let package = Package(
  name: "AdventOfCode",
  platforms: [.macOS(.v13), .iOS(.v16), .watchOS(.v9), .tvOS(.v16)],
  dependencies: [
    .package(
      url: "https://github.com/apple/swift-algorithms.git",
      .upToNextMajor(from: "1.2.0")),
    .package(
      url: "https://github.com/apple/swift-collections.git",
      .upToNextMajor(from: "1.1.4")),
    .package(
      url: "https://github.com/apple/swift-argument-parser.git",
      .upToNextMajor(from: "1.5.0")),
    .package(
      url: "https://github.com/swiftlang/swift-format.git",
      .upToNextMajor(from: "600.0.0")),
    .package(url: "https://github.com/ordo-one/package-benchmark", .upToNextMajor(from: "1.4.0")),
  ],
  targets: [
    .target(
      name: "AdventOfCodeKit",
      dependencies: dependencies,
      resources: [.copy("Data")]
    ),
    .testTarget(
      name: "AdventOfCodeKitTests",
      dependencies: ["AdventOfCodeKit"] + dependencies
    ),
    .executableTarget(
      name: "AdventOfCode",
      dependencies: [
        .product(name: "ArgumentParser", package: "swift-argument-parser"),
        "AdventOfCodeKit"
      ] + dependencies
    ),
    .executableTarget(
      name: "AOCBenchmark",
      dependencies: [
        "AdventOfCodeKit",
        .product(name: "Benchmark", package: "package-benchmark"),
      ] + dependencies,
      path: "Benchmarks/AOCBenchmark",
      plugins: [
        .plugin(name: "BenchmarkPlugin", package: "package-benchmark"),
      ]
    ),
  ],
  swiftLanguageModes: [.v6]
)
