import Foundation

public struct Day02: AdventDay {
  public var data: String

  public init(data: String) {
    self.data = data
  }

  public static var day: Int { 2 }

  public func part1() -> Any {
    data.utf8
      .split(separator: 10, omittingEmptySubsequences: true)
      .count {
        Self.isValid(report: $0.split(separator: 32).map(Int.init(uInt8Sequence:)))
      }
  }

  public func part2() -> Any {
    data.utf8
      .split(separator: 10, omittingEmptySubsequences: true)
      .count {
        let numbers = $0.split(separator: 32).map(Int.init(uInt8Sequence:))
        return Self.isValid(report: numbers) || Self.isValid2(report: numbers)
      }
  }

  static func isValid(report: [Int]) -> Bool {
    var isIncreasing: Bool?
    for pair in report.adjacentPairs() {
      let diff = abs(pair.0 - pair.1)
      guard diff > 0 && diff < 4 else { return false }
      guard let isIncreasing else {
        isIncreasing = pair.0 < pair.1
        continue
      }
      if (isIncreasing && pair.0 > pair.1) || (!isIncreasing && pair.0 < pair.1) {
        return false
      }
    }
    return true
  }

  static func isValid2(report: [Int]) -> Bool {
    let indexed = report.indexed()
    for i in 0..<report.count {
      let subReport = indexed.filter { $0.0 != i }
      if isValid(report: subReport.map(\.element)) {
        return true
      }
    }
    return false
  }
}
