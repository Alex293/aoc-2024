import Foundation

public struct Day01_Manual_Split_2: AdventDay {
  public var data: String

  public init(data: String) {
    self.data = data
  }

  public static var day: Int { 1 }

  public func part1() -> Any {
    let pairs = data.utf8
      .split(omittingEmptySubsequences: true, whereSeparator: { $0 == 32 || $0 == 10 })
      .map { Int(uInt8Sequence: $0) }

    let count = pairs.count / 2
    var left = [Int]()
    left.reserveCapacity(count)
    var right = [Int]()
    right.reserveCapacity(count)

    for i in stride(from: 0, to: pairs.count, by: 2) {
      left.append(pairs[i])
      right.append(pairs[i + 1])
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
