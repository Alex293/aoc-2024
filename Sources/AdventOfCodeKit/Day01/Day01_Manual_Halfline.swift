import Foundation

public struct Day01_Manual_Halfline: AdventDay {
  public var data: String

  public init(data: String) {
    self.data = data
  }

  public static var day: Int { 1 }

  public func part1() -> Any {
    var tmp = data.utf8[...]
    var left = [Int]()
    var right = [Int]()

    while !tmp.isEmpty {
      let line: Substring.UTF8View = tmp.prefix { (codeUnit: UTF8.CodeUnit) in codeUnit != 10 }
      let lengthOfNumber = (line.count - 3) / 2
      let leftNumberBytes = line[line.startIndex ..< line.index(line.startIndex, offsetBy: lengthOfNumber)]
      let leftInt: Int = leftNumberBytes.reduce(into: 0, { sum, char in sum = sum * 10 + Int(char) - 48 })
      left.append(leftInt)
      let rightNumberBytes = line[line.index(line.startIndex, offsetBy: lengthOfNumber + 3)...]
      let rightInt: Int = rightNumberBytes.reduce(into: 0, { sum, char in sum = sum * 10 + Int(char) - 48 })
      right.append(rightInt)
      tmp = tmp.dropFirst(line.count + 1)
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
