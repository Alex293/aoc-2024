import Testing

@testable import AdventOfCodeKit


struct Day06Tests {
  let testData = """
  ....#.....
  .........#
  ..........
  ..#.......
  .......#..
  ..........
  .#..^.....
  ........#.
  #.........
  ......#...
  
  """

  @Test("Part 1") func testPart1() async throws {
    let challenge = Day06(data: testData)
    #expect(String(describing: challenge.part1()) == "41")
  }

  @Test("Part 2") func testPart2() async throws {
    let challenge = Day06(data: testData)
    #expect(String(describing: challenge.part2()) == "6")
  }
}
