import Foundation

public struct Day01_RegexLiteral_Reserve: AdventDay {
  public var data: String

  public init(data: String) {
    self.data = data
  }

  public static var day: Int { 1 }

  public func part1() -> Any {
    let lineParser = /(\d+)   (\d+)/
    let matches = data
      .matches(of: lineParser)
    let count = matches.count
    var left = [Int]()
    left.reserveCapacity(count)
    var right = [Int]()
    right.reserveCapacity(count)

    for match in matches {
      left.append(Int(match.1)!)
      right.append(Int(match.2)!)
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
