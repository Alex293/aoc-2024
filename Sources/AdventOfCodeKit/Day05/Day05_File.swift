import Foundation

public struct Day05_File: AdventDay {
  public var data: String

  public init(data: String) {
    self.data = data
  }

  public static var day: Int { 5 }

  public func part1() -> Int {
    let file = fopen("/Users/alexis/Project/aoc-2024/Sources/AdventOfCodeKit/Data/Day05.txt", "r")
    defer { fclose(file) }
    fseek(file, 0, SEEK_END)
    let byteCount = ftell(file)
    fseek(file, 0, SEEK_SET)
    let pointer = UnsafeMutableRawPointer.allocate(byteCount: byteCount, alignment: 1)
    defer { pointer.deallocate() }
    _ = fread(pointer, 1, byteCount, file)
    let b = UnsafeRawBufferPointer(start: pointer, count: byteCount)

    var rules = [Int: Set<Int>]()
    var pages = [[Int]]()
    var currentPage = [Int]()
    var i = 0
    while b[i&+5] == 10 {
      let key = Int(uInt8Sequence: b[i...i&+1])
      var currentSet = rules[key] ?? []
      currentSet.insert(Int(uInt8Sequence: b[i&+3...i&+4]))
      rules[key] = currentSet
      i &+= 6
    }
    while i < byteCount &- 2 {
      currentPage.append(Int(uInt8Sequence: b[i&+1...i&+2]))
      if b[i&+3] == 10 {
        pages.append(currentPage)
        currentPage = []
      }
      i &+= 3
    }
    return pages.reduce(into: 0) { sum, page in
      var visited = Set<Int>()
      for n in page.dropFirst() {
        if rules[n]?.isDisjoint(with: visited) == false {
          return
        }
        visited.insert(n)
      }
      sum &+= page[page.count/2]
    }
  }

  public func part2() -> Int {
    let file = fopen("/Users/alexis/Project/aoc-2024/Sources/AdventOfCodeKit/Data/Day05.txt", "r")
    defer { fclose(file) }
    fseek(file, 0, SEEK_END)
    let byteCount = ftell(file)
    fseek(file, 0, SEEK_SET)
    let pointer = UnsafeMutableRawPointer.allocate(byteCount: byteCount, alignment: 1)
    defer { pointer.deallocate() }
    _ = fread(pointer, 1, byteCount, file)
    let b = UnsafeRawBufferPointer(start: pointer, count: byteCount)

    var rules = [Int: Set<Int>]()
    var pages = [[Int]]()
    var currentPage = [Int]()

    var i = 0
    while b[i&+5] == 10 {
      let key = Int(uInt8Sequence: b[i...i&+1])
      var currentSet = rules[key] ?? []
      currentSet.insert(Int(uInt8Sequence: b[i&+3...i&+4]))
      rules[key] = currentSet
      i &+= 6
    }
    while i < byteCount &- 2 {
      currentPage.append(Int(uInt8Sequence: b[i&+1...i&+2]))
      if b[i&+3] == 10 {
        pages.append(currentPage)
        currentPage = []
      }
      i &+= 3
    }
    return pages.reduce(into: 0) { sum, page in
      var visited = Set<Int>()
      for n in page.dropFirst() {
        if let nRules = rules[n], !nRules.isDisjoint(with: visited) {
          sum &+= page
            .sorted { rules[$0]?.contains($1) == false }[page.count/2]
          return
        }
        visited.insert(n)
      }
    }
  }
}
