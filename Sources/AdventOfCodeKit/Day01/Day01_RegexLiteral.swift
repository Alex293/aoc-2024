import Foundation

public struct Day01_RegexLiteral: AdventDay {
  public var data: String

  public init(data: String) {
    self.data = data
  }

  public static var day: Int { 1 }

  nonisolated(unsafe) private static let lineParser = /(\d+)   (\d+)/

  public func part1() -> Any {
    let (firstList, secondList) = data
      .matches(of: Self.lineParser)
      .reduce(into: ([Int](), [Int]())) { $0.0.append(Int($1.1)!) ; $0.1.append(Int($1.2)!) }
    return zip(firstList.sorted(), secondList.sorted())
      .reduce(0) { $0 + abs($1.1 - $1.0) }
  }

  public func part2() -> Any {
    let (list, occurences) = data
      .matches(of: Self.lineParser)
      .reduce(into: ([Int](), [Int: Int]())) {
        $0.0.append(Int($1.1)!)
        let number = Int($1.2)!
        $0.1[number] = ($0.1[number] ?? 0) + 1
      }
    return list.reduce(0) { sum, number in sum + (occurences[number] ?? 0) * number }
  }
}
