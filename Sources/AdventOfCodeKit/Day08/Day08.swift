import Foundation
import RegexBuilder
import Algorithms

public struct Day08: AdventDay {
  public var data: String

  public init(data: String) {
    self.data = data
  }

  public static var day: Int { 8 }

  public func part1() -> Int {
    let array = data
      .split(separator: "\n")
      .map(Array.init)

    struct Pos: Hashable {
      let x, y: Int
    }
    var dict = [Character: Set<Pos>]()

    let maxX = array[0].count
    let maxY = array.count

    for y in 0..<maxY {
      for (x, c) in array[y].indexed() {
        guard c.isLetter || c.isNumber else {
          continue
        }
        var set = dict[c] ?? Set()
        set.insert(Pos(x: x, y: y))
        dict[c] = set
      }
    }

    var cPoses = Set<Pos>()
    for (_, poses) in dict {
      for posA in poses {
        for posB in poses.subtracting([posA]) {
          let xDistance = posB.x - posA.x
          let yDistance = posB.y - posA.y

          let eX = posA.x - xDistance
          let eY = posA.y - yDistance

          let fX = posB.x + xDistance
          let fY = posB.y + yDistance

          if eX >= 0 && eX < maxX && eY >= 0 && eY < maxY {
            cPoses.insert(Pos(x: eX, y: eY))
          }

          if fX >= 0 && fX < maxX && fY >= 0 && fY < maxY {
            cPoses.insert(Pos(x: fX, y: fY))
          }
        }
      }
    }

//    var text = ""
//    for y in 0..<maxY {
//      for x in 0..<maxX {
//        if cPoses.contains(Pos(x: x, y: y)) {
//          text.append("#")
//        } else {
//          text.append(array[y][x])
//        }
//      }
//      text.append("\n")
//    }
//
//    print(text)

    return cPoses.count
  }

  public func part2() -> Int {
    let array = data
      .split(separator: "\n")
      .map(Array.init)

    struct Pos: Hashable {
      let x, y: Int
    }
    var dict = [Character: Set<Pos>]()

    let maxX = array[0].count
    let maxY = array.count

    for y in 0..<maxY {
      for (x, c) in array[y].indexed() {
        guard c.isLetter || c.isNumber else {
          continue
        }
        var set = dict[c] ?? Set()
        set.insert(Pos(x: x, y: y))
        dict[c] = set
      }
    }

    var cPoses = Set<Pos>()
    for (_, poses) in dict {
      for posA in poses {
        cPoses.insert(posA)
        for posB in poses.subtracting([posA]) {

          cPoses.insert(posB)

          let xDistance = posB.x - posA.x
          let yDistance = posB.y - posA.y

          var eX = posA.x - xDistance
          var eY = posA.y - yDistance

          var fX = posB.x + xDistance
          var fY = posB.y + yDistance

          while true {
            if eX >= 0 && eX < maxX && eY >= 0 && eY < maxY {
              cPoses.insert(Pos(x: eX, y: eY))
              eX -= xDistance
              eY -= yDistance
            } else {
              break
            }
          }

          while true {
            if fX >= 0 && fX < maxX && fY >= 0 && fY < maxY {
              cPoses.insert(Pos(x: fX, y: fY))
              fX -= xDistance
              fY -= yDistance
            } else {
              break
            }
          }
        }
      }
    }

//    var text = ""
//    for y in 0..<maxY {
//      for x in 0..<maxX {
//        if cPoses.contains(Pos(x: x, y: y)) {
//          text.append("#")
//        } else {
//          text.append(array[y][x])
//        }
//      }
//      text.append("\n")
//    }
//
//    print(text)

    return cPoses.count
  }
}
