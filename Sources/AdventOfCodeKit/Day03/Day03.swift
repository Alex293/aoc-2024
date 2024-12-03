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
    let filters = (
      data.matches(of: /do\(\)/).map { ($0.startIndex, true) }
      + data.matches(of: /don't\(\)/).map { ($0.startIndex, false) }
    ).sorted(by: { $0.0 > $1.0 })
    return data
      .matches(of: /mul\((\d{1,3}),(\d{1,3})\)/)
      .filter { match in
        filters.first(where: { $0.0 < match.output.1.startIndex })?.1 ?? true
      }
      .reduce(into: 0) { $0 += Int($1.1)! &* Int($1.2)! }
  }
}
