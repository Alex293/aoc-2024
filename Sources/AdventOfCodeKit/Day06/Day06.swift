import Foundation

public struct Day06: AdventDay {
  public var data: String

  public init(data: String) {
    self.data = data
  }

  public static var day: Int { 6 }

  public func part1() -> Any {
    data.utf8.withContiguousStorageIfAvailable { b in
      let count = b.count
      var lineLength = 0
      while b[lineLength] != 10 {
        lineLength &+= 1
      }
      lineLength &+= 1

      struct Pos: Hashable {
        let l, c: Int
      }

      let obs: UInt8 = 35
      let gu: UInt8 = 94
      let gd: UInt8 = 118
      let gr: UInt8 = 62
      let gl: UInt8 = 60

      var obstaclesPositions = Set<Pos>()
      var guardVisitedPositions = Set<Pos>()
      var guardPos: Pos!

      let lineCount = b.count / lineLength

      for l in stride(from: 0, to: count / lineLength, by: 1) {
        for c in stride(from: 0, to: lineLength, by: 1) {
          switch b[l, c, lineLength] {
          case obs: obstaclesPositions.insert(Pos(l: l, c: c))
          case gu, gd, gr, gl: guardPos = Pos(l: l, c: c)
          default: continue
          }
        }
      }
      guardVisitedPositions.insert(guardPos)

      var guardDir: UInt8 = b[guardPos.l, guardPos.c, lineLength]

      outer: while true {
        switch guardDir {
        case gu:
          for l in stride(from: guardPos.l, to: -1, by: -1) {
            guardVisitedPositions.insert(.init(l: l, c: guardPos.c))
            guard l > 0 else { break outer }
            if b[l&-1, guardPos.c, lineLength] == obs {
              guardPos = .init(l: l, c: guardPos.c)
              guardDir = gr
              break
            }
          }
        case gd:
          for l in stride(from: guardPos.l, to: lineCount, by: 1) {
            guardVisitedPositions.insert(.init(l: l, c: guardPos.c))
            guard l < lineCount &- 1 else { break outer }
            if b[l&+1, guardPos.c, lineLength] == obs {
              guardPos = .init(l: l, c: guardPos.c)
              guardDir = gl
              break
            }
          }
        case gr:
          for c in stride(from: guardPos.c, to: lineLength, by: 1) {
            guardVisitedPositions.insert(.init(l: guardPos.l, c: c))
            guard c < lineLength &- 1 else { break outer }
            if b[guardPos.l, c&+1, lineLength] == obs {
              guardPos = .init(l: guardPos.l, c: c)
              guardDir = gd
              break
            }
          }
        case gl:
          for c in stride(from: guardPos.c, to: -1, by: -1) {
            guardVisitedPositions.insert(.init(l: guardPos.l, c: c))
            guard c > 0 else { break outer }
            if b[guardPos.l, c&-1, lineLength] == obs {
              guardPos = .init(l: guardPos.l, c: c)
              guardDir = gu
              break
            }
          }
        default: preconditionFailure()
        }
      }
      return guardVisitedPositions.count
    }!
  }

  public func part2() -> Any {
    return 0
//    data.utf8.withContiguousStorageIfAvailable { b in
//      let count = b.count
//      var lineLength = 0
//      while b[lineLength] != 10 {
//        lineLength &+= 1
//      }
//      lineLength &+= 1
//
//      struct Pos: Hashable {
//        let l, c: Int
//      }
//
//      let obs: UInt8 = 35
//      let gu: UInt8 = 94
//      let gd: UInt8 = 118
//      let gr: UInt8 = 62
//      let gl: UInt8 = 60
//
//      var obstaclesPositions = Set<Pos>()
//      var guardVisitedPositions = Set<Pos>()
//      var guardPos: Pos!
//
//      let lineCount = b.count / lineLength
//
//      for l in stride(from: 0, to: count / lineLength, by: 1) {
//        for c in stride(from: 0, to: lineLength, by: 1) {
//          switch b[l, c, lineLength] {
//          case obs: obstaclesPositions.insert(Pos(l: l, c: c))
//          case gu, gd, gr, gl: guardPos = Pos(l: l, c: c)
//          default: continue
//          }
//        }
//      }
//      guardVisitedPositions.insert(guardPos)
//
//      var guardDir: UInt8 = b[guardPos.l, guardPos.c, lineLength]
//
//      outer: while true {
//        switch guardDir {
//        case gu:
//          for l in stride(from: guardPos.l, to: -1, by: -1) {
//            guardVisitedPositions.insert(.init(l: l, c: guardPos.c))
//            guard l > 0 else { break outer }
//            if b[l-1, guardPos.c, lineLength] == obs {
//              guardPos = .init(l: l, c: guardPos.c)
//              guardDir = gr
//              break
//            }
//          }
//        case gd:
//          for l in stride(from: guardPos.l, to: lineCount, by: 1) {
//            guardVisitedPositions.insert(.init(l: l, c: guardPos.c))
//            guard l < lineCount - 1 else { break outer }
//            if b[l+1, guardPos.c, lineLength] == obs {
//              guardPos = .init(l: l, c: guardPos.c)
//              guardDir = gl
//              break
//            }
//          }
//        case gr:
//          for c in stride(from: guardPos.c, to: lineLength, by: 1) {
//            guardVisitedPositions.insert(.init(l: guardPos.l, c: c))
//            guard c < lineLength - 1 else { break outer }
//            if b[guardPos.l, c+1, lineLength] == obs {
//              guardPos = .init(l: guardPos.l, c: c)
//              guardDir = gd
//              break
//            }
//          }
//        case gl:
//          for c in stride(from: guardPos.c, to: -1, by: -1) {
//            guardVisitedPositions.insert(.init(l: guardPos.l, c: c))
//            guard c > 0 else { break outer }
//            if b[guardPos.l, c-1, lineLength] == obs {
//              guardPos = .init(l: guardPos.l, c: c)
//              guardDir = gu
//              break
//            }
//          }
//        default: preconditionFailure()
//        }
//      }
//      return guardVisitedPositions.count
//    }!
  }
}

extension UnsafeBufferPointer where Element == UInt8 {
  @inlinable
  @inline(__always)
  subscript (line: Int, column: Int, lineLenght: Int) -> UInt8 {
    _read {
      yield self[line * lineLenght + column]
    }
  }
}
