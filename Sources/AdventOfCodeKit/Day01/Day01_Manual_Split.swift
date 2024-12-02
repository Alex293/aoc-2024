import Foundation

public struct Day01_Manual_Split: AdventDay {
  public var data: String

  public init(data: String) {
    self.data = data
  }

  public static var day: Int { 1 }

  public func part1() -> Any {
    let pairs = data.utf8
      .split(omittingEmptySubsequences: true, whereSeparator: { $0 == 32 || $0 == 10 })
      .map { $0.reduce(into: 0, { sum, char in sum = sum * 10 + Int(char) - 48 }) }

    let count = pairs.count / 2
    var left = [Int]()
    left.reserveCapacity(count)
    var right = [Int]()
    right.reserveCapacity(count)

    for pair in pairs.striding(by: 2) {
      left.append(pair)
    }

    for pair in pairs[1...].striding(by: 2) {
      right.append(pair)
    }

    return zip(left.sorted(), right.sorted())
      .reduce(0) { $0 + abs($1.1 - $1.0) }
  }

  public func part2() -> Any {
    let lineParser = /(\d+)   (\d+)/
    let (list, occurences) = data
      .matches(of: lineParser)
      .reduce(into: ([Int](), [Int: Int]())) {
        $0.0.append(Int($1.1)!)
        let number = Int($1.2)!
        $0.1[number] = ($0.1[number] ?? 0) + 1
      }
    return list.reduce(0) { sum, number in sum + (occurences[number] ?? 0) * number }
  }
}
