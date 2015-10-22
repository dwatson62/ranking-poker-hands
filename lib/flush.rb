class Flush
  def self.check(hand)
    suit = hand[0][1]
    hand.select { |card| card[1] == suit }.length == hand.length
  end
end
