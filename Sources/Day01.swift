import Algorithms
import RegexBuilder

struct Day01: AdventDay {
  var data: String

  nonisolated(unsafe) static let lineParser = Regex {
    Capture { OneOrMore(.digit) } transform: { Int($0)! }
    "   "
    Capture { OneOrMore(.digit) } transform: { Int($0)! }
    Anchor.endOfLine
  }

  func part1() -> Any {
    let (firstList, secondList) = data
      .matches(of: Self.lineParser)
      .reduce(into: ([Int](), [Int]())) { $0.0.append($1.1) ; $0.1.append($1.2) }
    return zip(firstList.sorted(), secondList.sorted())
      .reduce(0) { $0 + abs($1.1 - $1.0) }
  }

  func part2() -> Any {
    let (list, occurences) = data
      .matches(of: Self.lineParser)
      .reduce(into: ([Int](), [Int: Int]())) {
        $0.0.append($1.1)
        $0.1[$1.2] = ($0.1[$1.2] ?? 0) + 1
      }
    return list.reduce(0) { sum, number in sum + (occurences[number] ?? 0) * number }
  }
}
