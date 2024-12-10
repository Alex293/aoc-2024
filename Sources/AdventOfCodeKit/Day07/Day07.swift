import Foundation
import RegexBuilder
import Algorithms

public struct Day07: AdventDay {
  public var data: String

  public init(data: String) {
    self.data = data
  }

  public static var day: Int { 7 }

  public func part1() -> Any {
    data
      .split(separator: "\n")
      .map { line in
        let parts = line.split(separator: ":")
        let expectation = Int(parts[0])!
        let numbers = parts[1].split(separator: " ").map { Int($0)! }
        return (expectation, numbers)
      }
      .reduce(into: 0) { (sum: inout Int, equation: (Int, [Int])) in
        let isValid = isValid(equation.0, equation.1[...])
        print("Equation: \(equation) \(isValid ? "valid" : "invalid")")
        sum += isValid ? equation.0 : 0
      }
  }

  func isValid(_ expected: Int, _ inputs: ArraySlice<Int>) -> Bool {
    guard inputs.count > 1 else { return expected == inputs.first! }
    var inputs = inputs
    let last = inputs.removeLast()
    if expected > last && isValid(expected - last, inputs) {
      return true
    }
    if expected.isMultiple(of: last) && isValid(expected / last, inputs) {
      return true
    }
    return false
  }

  public func part2() -> Any {
    data
      .split(separator: "\n")
      .map { line in
        let parts = line.split(separator: ":")
        let expectation = Int(parts[0])!
        let numbers = parts[1].split(separator: " ").map { Int($0)! }
        return (expectation, numbers)
      }
      .reduce(into: 0) { (sum: inout Int, equation: (Int, [Int])) in
        let isValid = isValid2(equation.0, equation.1[...])
        print("Equation: \(equation) \(isValid ? "valid" : "invalid")")
        sum += isValid ? equation.0 : 0
      }
  }

  func isValid2(_ expected: Int, _ inputs: ArraySlice<Int>) -> Bool {
    guard inputs.count > 1 else { return expected == inputs.first! }
    var inputs = inputs
    let last = inputs.removeLast()
    if expected > last && isValid2(expected - last, inputs) {
      return true
    }
    if expected.isMultiple(of: last) && isValid2(expected / last, inputs) {
      return true
    }
    var power = 10
    while last > power { power *= 10 }
    if expected % power == last && isValid2(expected / power, inputs) {
      return true
    }
    return false
  }
}
