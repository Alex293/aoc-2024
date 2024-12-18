import Testing

@testable import AdventOfCodeKit

// Make a copy of this file for every day to ensure the provided smoke tests
// pass.
struct Day01Tests {
  // Smoke test data provided in the challenge question
  let testData = """
  3   4
  4   3
  2   5
  1   3
  3   9
  3   3
  """

  @Test("Part 1") func testRegexBuilderPart1() async throws {
    let challenge = Day01(data: testData)
    #expect(String(describing: challenge.part1()) == "11")
  }

  @Test("Part 2") func testRegexBuilderPart2() async throws {
    let challenge = Day01(data: testData)
    #expect(String(describing: challenge.part2()) == "31")
  }
}
