class FullHouse
  def self.check(hand)
    group = hand.map { |element| element.chr }
    FullHouse.x_of_a_kind(group, 3).any? && FullHouse.x_of_a_kind(group, 2).any?
  end

  def self.x_of_a_kind(group, x)
    group.select { |element| group.count(element) == x }
  end
end
