import Testing
import AdventOfCodeKit


@Test func testASCIIToInt() async throws {
  let int: Int = "1000".utf8.withContiguousStorageIfAvailable {
    Int(uInt8Sequence: $0)
  }!
  #expect(int == 1000)
}
