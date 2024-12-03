import Foundation

public struct Day01_Manual_Range: AdventDay {
  public let data: String

  public init(data: String) {
    self.data = data
  }

  public static var day: Int { 1 }

  public func part1() -> Any {
    data.utf8.withContiguousStorageIfAvailable { b in
      let numberLength = b.firstIndex(of: 32)!

      let lineLenght = numberLength &+ numberLength &+ 3 &+ 1
      let count = b.count
      let lines = count / lineLenght

      var left = [Int]()
      left.reserveCapacity(lines)
      var right = [Int]()
      right.reserveCapacity(lines)

      for i in stride(from: 0, to: count &- 1, by: lineLenght) {
        left.append(Int(uInt8Sequence: b[i ..< i &+ numberLength]))
        right.append(Int(uInt8Sequence: b[i &+ 3 &+ numberLength ..< i &+ lineLenght &- 1]))
      }
      return zip(left.sorted(), right.sorted()).reduce(0) { $0 &+ abs($1.1 &- $1.0) }
    }!
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
