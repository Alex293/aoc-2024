import Foundation

public struct Day04: AdventDay {
  public var data: String

  public init(data: String) {
    self.data = data
  }

  public static var day: Int { 4 }

  public func part1() -> Any {
    data.utf8.withContiguousStorageIfAvailable { b in
      let a = 65
      let m = 77
      let s = 83
      let x = 88
      let lineLength = b.firstIndex(of: 10)! &+ 1
      let count = b.count
      var found = 0
      let maxC = count / lineLength &- 3
      let maxL = lineLength &- 4
      for i in 0..<count {
        // Look for all X
        if b[i] != x { continue }

        let l = i % lineLength
        let c = i / lineLength

        let canCheckRight = l < maxL
        let canCheckLeft = l > 2
        let canCheckUp = c > 2
        let canCheckDown = c < maxC

        // right
        if canCheckRight && b[i&+1] == m && b[i&+2] == a && b[i&+3] == s  {
          found &+= 1
        }
        // left
        if canCheckLeft && b[i&-1] == m && b[i&-2] == a && b[i&-3] == s  {
          found &+= 1
        }
        // down
        if canCheckDown && b[i &+ lineLength] == m && b[i &+ 2 &* lineLength] == a && b[i &+ 3 &* lineLength] == s {
          found &+= 1
        }
        // up
        if canCheckUp && b[i &- lineLength] == m && b[i &- 2 &* lineLength] == a && b[i &- 3 &* lineLength] == s {
          found &+= 1
        }
        // Diagonal down right
        if canCheckDown && canCheckRight && b [i &+ 1 &+ lineLength] == m &&  b [i &+ 2 &+ 2 &* lineLength] == a &&  b [i &+ 3 &+ 3 &* lineLength] == s {
          found &+= 1
        }
        // Diagonal down left
        if canCheckDown && canCheckLeft && b[i &- 1 &+ lineLength] == m && b [i &- 2 &+ 2 &* lineLength] == a && b[i &- 3 &+ 3 &* lineLength] == s {
          found &+= 1
        }
        // Diagonal up right
        if canCheckUp && canCheckRight && b [i &+ 1 &- lineLength] == m &&  b [i &+ 2 &- 2 &* lineLength] == a &&  b [i &+ 3 &- 3 &* lineLength] == s {
          found &+= 1
        }
        // Diagonal up left
        if canCheckUp && canCheckLeft && b [i &- 1 &- lineLength] == m && b[i &- 2 &- 2 &* lineLength] == a &&  b [i &- 3 &- 3 &* lineLength] == s {
          found &+= 1
        }
      }
      return found
    }!
  }

  public func part2() -> Any {
    data.utf8.withContiguousStorageIfAvailable { b in
      let count = b.count

      var lineLength = 0
      while b[lineLength] != 10 {
        lineLength &+= 1
      }
      lineLength &+= 1

      let maxColumn = lineLength &- 2
      let maxLine = count / lineLength &- 1

      let ldOffset = -1 &+ lineLength
      let luOffset = -1 &- lineLength
      let ruOffset = 1 &- lineLength
      let rdOffset = 1 &+ lineLength

      var found = 0
      var startOfLine = 0
      for _ in 1..<maxLine {
        startOfLine += lineLength
        for c in 1..<maxColumn {
          let i = c &+ startOfLine
          guard b[i] == 65 else { continue }
          let ld: UInt8 = b[i &+ ldOffset]
          let lu: UInt8 = b[i &+ luOffset]
          let ru: UInt8 = b[i &+ ruOffset]
          let rd: UInt8 = b[i &+ rdOffset]
          switch (lu, rd, ld, ru) {
          case
            (77, 83, 77, 83),
            (77, 83, 83, 77),
            (83, 77, 83, 77),
            (83, 77, 77, 83):
            found &+= 1
          default: continue
          }
        }
      }
      return found
    }!
  }
}