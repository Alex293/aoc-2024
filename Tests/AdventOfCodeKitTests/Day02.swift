import Testing

@testable import AdventOfCodeKit


struct Day02Tests {
  let testData = """
  7 6 4 2 1
  1 2 7 8 9
  9 7 6 2 1
  1 3 2 4 5
  8 6 4 4 1
  1 3 6 7 9
  """

  @Test("Part 1") func testPart1() async throws {
    let challenge = Day02(data: testData)
    #expect(String(describing: challenge.part1()) == "2")
  }

  @Test("Part 2") func testPart2() async throws {
    let challenge = Day02(data: testData)
    #expect(String(describing: challenge.part2()) == "4")
  }

  @Test func test() async throws {
    #expect(Day02.isValid(report: [7, 6, 4, 2, 1]) == true)
    #expect(Day02.isValid2(report: [1, 2, 7, 8, 9]) == false)
    #expect(Day02.isValid2(report: [9, 7, 6, 2, 1]) == false)
    #expect(Day02.isValid2(report: [1, 3, 2, 4, 5]) == true)
    #expect(Day02.isValid2(report: [8, 6, 4, 4, 1]) == true)
    #expect(Day02.isValid(report: [1, 3, 6, 7, 9]) == true)
  }
}
