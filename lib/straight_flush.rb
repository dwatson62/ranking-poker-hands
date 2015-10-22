class StraightFlush
  def self.check(hand)
    Flush.check(hand) && Straight.check(hand)
  end
end
