import Foundation

public struct Day05: AdventDay {
  public var data: String

  public init(data: String) {
    self.data = data
  }

  public static var day: Int { 5 }

  public func part1() -> Any {
    data.utf8.withContiguousStorageIfAvailable { b in
      var rules = [Int: Set<Int>]()
      var pages = [[Int]]()
      for i in stride(from: 0, to: b.count, by: 6) {
        guard b[i+5] == 10 else {
          var currentPage = [Int]()
          for j in stride(from: b.count - 2, to: i, by: -3) {
            currentPage.append(Int(uInt8Sequence: b[j-1...j]))
            if b[j-2] == 10 {
              pages.append(currentPage.reversed())
              currentPage = []
            }
          }
          break
        }
        var currentSet = rules[Int(uInt8Sequence: b[i...i+1])] ?? []
        currentSet.insert(Int(uInt8Sequence: b[i+3...i+4]))
        rules[Int(uInt8Sequence: b[i...i+1])] = currentSet
      }
      return pages.reduce(into: 0) { sum, page in
        var visited = Set<Int>()
        for n in page {
          if let rules = rules[n], !rules.isEmpty && !visited.isEmpty && !rules.isDisjoint(with: visited) {
              return
          }
          visited.insert(n)
        }
        sum += page[page.count/2]
      }
    }!
  }

  public func part2() -> Any {
    data.utf8.withContiguousStorageIfAvailable { b in
      var rules = [Int: Set<Int>]()
      var pages = [[Int]]()
      for i in stride(from: 0, to: b.count, by: 6) {
        guard b[i+5] == 10 else {
          var currentPage = [Int]()
          for j in stride(from: b.count - 2, to: i, by: -3) {
            currentPage.append(Int(uInt8Sequence: b[j-1...j]))
            if b[j-2] == 10 {
              pages.append(currentPage.reversed())
              currentPage = []
            }
          }
          break
        }
        var currentSet = rules[Int(uInt8Sequence: b[i...i+1])] ?? []
        currentSet.insert(Int(uInt8Sequence: b[i+3...i+4]))
        rules[Int(uInt8Sequence: b[i...i+1])] = currentSet
      }
      return pages.reduce(into: 0) { sum, page in
        var visited = Set<Int>()
        for n in page {
          if let nRules = rules[n], !nRules.isEmpty && !visited.isEmpty && !nRules.isDisjoint(with: visited) {
            sum += page
              .sorted { lhs, rhs in
                guard let rule = rules[lhs] else { return true }
                return !rule.contains(rhs)
              }[page.count/2]
            return
          }
          visited.insert(n)
        }
      }
    }!
  }
}
