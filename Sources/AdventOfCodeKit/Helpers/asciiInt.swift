public extension Int {
  @inlinable
  @inline(__always)
  init(uInt8Sequence: some Sequence<UInt8>) {
    self = uInt8Sequence.reduce(into: Int(0), { sum, char in
      sum = ((sum &* 10) &+ (Int(char) &- 48))
    })
  }
}
