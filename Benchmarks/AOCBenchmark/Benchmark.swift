import AdventOfCodeKit
import Benchmark

@MainActor
let benchmarks = {

  let configuration = Benchmark.Configuration(metrics: .microbenchmark, maxDuration: .seconds(5))

  Benchmark("Day01 - Part 1", configuration: configuration) { benchmark in
    let day01 = Day01()
    benchmark.startMeasurement()
    blackHole(day01.part1())
    benchmark.stopMeasurement()
  }

//  Benchmark("Day01 - Part 2", configuration: configuration) { benchmark in
//    let day01 = Day01()
//    benchmark.startMeasurement()
//    blackHole(day01.part2())
//    benchmark.stopMeasurement()
//  }
}
