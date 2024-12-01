import AdventOfCodeKit
import Benchmark

@MainActor
let benchmarks = {

  let configuration = Benchmark.Configuration(metrics: .all, maxDuration: .seconds(10))

  Benchmark("Day01 - Part 1", configuration: configuration) { benchmark in
    let day01 = Day01()
    benchmark.startMeasurement()
    blackHole(day01.part1())
    benchmark.stopMeasurement()
  }

  Benchmark("Day01 - Part 2", configuration: configuration) { benchmark in
    let day01 = Day01()
    benchmark.startMeasurement()
    blackHole(day01.part2())
    benchmark.stopMeasurement()
  }
}
