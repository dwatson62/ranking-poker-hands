class Straight
  def self.check(hand)
    numbers = CardValues.return_sorted_values(hand)
    return true if Straight.check_sequential(numbers)
    Straight.aces_are_low(numbers) if numbers.include?('14')
  end

  def self.check_sequential(numbers)
    numbers.each_cons(2).all? { |x, y| y == x.next }
  end

  def self.aces_are_low(numbers)
    numbers.delete('14')
    numbers.push('1').sort!
    Straight.check_sequential(numbers)
  end
end
