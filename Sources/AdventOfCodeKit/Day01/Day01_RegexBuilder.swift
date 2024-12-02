import RegexBuilder

public struct Day01_RegexBuilder: AdventDay {
  public var data: String

  public init(data: String) {
    self.data = data
  }

  public static var day: Int { 1 }

  public func part1() -> Any {
    let lineParser = Regex {
      Capture { OneOrMore(.digit) } transform: { Int($0)! }
      "   "
      Capture { OneOrMore(.digit) } transform: { Int($0)! }
      Anchor.endOfLine
    }
    let (firstList, secondList) = data
      .matches(of: lineParser)
      .reduce(into: ([Int](), [Int]())) { $0.0.append($1.1) ; $0.1.append($1.2) }
    return zip(firstList.sorted(), secondList.sorted())
      .reduce(0) { $0 + abs($1.1 - $1.0) }
  }

  public func part2() -> Any {
    let lineParser = Regex {
      Capture { OneOrMore(.digit) } transform: { Int($0)! }
      "   "
      Capture { OneOrMore(.digit) } transform: { Int($0)! }
      Anchor.endOfLine
    }
    let (list, occurences) = data
      .matches(of: lineParser)
      .reduce(into: ([Int](), [Int: Int]())) {
        $0.0.append($1.1)
        $0.1[$1.2] = ($0.1[$1.2] ?? 0) + 1
      }
    return list.reduce(0) { sum, number in sum + (occurences[number] ?? 0) * number }
  }
}
