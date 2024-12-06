import Foundation

public struct Day03: AdventDay {
  public var data: String

  public init(data: String) {
    self.data = data
  }

  public static var day: Int { 3 }

  public func part1() -> Any {
    data
      .matches(of: /mul\((\d{1,3}),(\d{1,3})\)/)
      .reduce(into: 0) { $0 += Int($1.1)! &* Int($1.2)! }
  }

  public func part2() -> Any {
    data
      .matches(of: /(do\(\)|don't\(\)|mul\((\d{1,3}),(\d{1,3})\))/)
      .reduce(into: (0, true)) { result, match in
        switch match.output.1.count {
        case 4: result.1 = true
        case 7: result.1 = false
        default:
          if result.1 {
            result.0 += Int(match.output.2!)! &* Int(match.output.3!)!
          }
        }
      }
      .0
  }
}
