class HandEvaluator

  attr_reader :left, :right

  CARDS = 5
  FACES = { 'J' => '11', 'Q' => '12', 'K' => '13', 'A' => '14' }

  def return_stronger_hand(left, right)
    rules = [StraightFlush, 'FourOfAKind', FullHouse, Flush, Straight, 'ThreeOfAKind', 'TwoPair', 'Pair']
    set_hands(left, right)
    rules.each do |rank|
      if rank == 'FourOfAKind'
        return hand_with_x_of_a_kind(4) if hand_with_x_of_a_kind(4)
      elsif rank == 'ThreeOfAKind'
        return hand_with_x_of_a_kind(3) if hand_with_x_of_a_kind(3)
      elsif rank == 'TwoPair' || rank == 'Pair'
        return hand_with_x_of_a_kind(2) if hand_with_x_of_a_kind(2)
      else
        return check_ranking(rank) if check_ranking(rank)
      end
    end
    compare_kickers
  end

  def set_hands(left, right)
    @left = left
    @right = right
  end

  def check_ranking(rank)
    return left if rank.check(left) && !rank.check(right)
    return right if !rank.check(left) && rank.check(right)
    return compare_kickers if rank.check(left) && rank.check(right)
    nil
  end

  def adjust_values(hand)
    check_hand = hand.map { |x| x[0...-1] }
    check_hand.map { |x| FACES[x] || x }.sort
  end

  def hand_with_x_of_a_kind(x)
    left_x_of_kind = get_x_of_a_kind(left, x)
    right_x_of_kind = get_x_of_a_kind(right, x)
    return if left_x_of_kind.none? && right_x_of_kind.none?
    return left if left_x_of_kind.length > right_x_of_kind.length
    return right if left_x_of_kind.length < right_x_of_kind.length
    hand_with_stronger_x(left_x_of_kind, right_x_of_kind)
  end

  def get_x_of_a_kind(hand, x)
    group = hand.map { |element| element.chr }
    group.select { |element| group.count(element) == x }.sort.reverse
  end

  def hand_with_stronger_x(left_x, right_x)
    for x in 0...left_x.length
      return left if left_x[x] > right_x[x]
      return right if left_x[x] < right_x[x]
    end
    compare_kickers
  end

  def compare_kickers
    sorted_left = adjust_values(left).reverse
    sorted_right = adjust_values(right).reverse
    for x in 0..CARDS
      return left if sorted_left[x] > sorted_right[x]
      return right if sorted_left[x] < sorted_right[x]
    end
  end

end

class Flush
  def self.check(hand)
    suit = hand[0][1]
    hand.select { |x| x[1] == suit }.length == 5
  end
end

class Straight < HandEvaluator
  def self.check(hand)
    check_hand = hand.map { |x| x[0...-1] }
    check_hand = check_hand.map { |x| FACES[x] || x }.sort
    check_hand.each_cons(2).all? { |x, y| y == x.next }
  end
end

class FullHouse
  def self.check(hand)
    group = hand.map { |element| element.chr }
    trips = group.select { |element| group.count(element) == 3 }
    pairs = group.select { |element| group.count(element) == 2 }
    trips.any? && pairs.any?
  end
end

class StraightFlush
  def self.check(hand)
    Flush.check(hand) && Straight.check(hand)
  end
end

class CardGroups

  def hand_with_x_of_a_kind(x)
    left_x_of_kind = get_x_of_a_kind(left, x)
    right_x_of_kind = get_x_of_a_kind(right, x)
    return if left_x_of_kind.none? && right_x_of_kind.none?
    return left if left_x_of_kind.length > right_x_of_kind.length
    return right if left_x_of_kind.length < right_x_of_kind.length
    hand_with_stronger_x(left_x_of_kind, right_x_of_kind)
  end

  def get_x_of_a_kind(hand, x)
    group = hand.map { |element| element.chr }
    group.select { |element| group.count(element) == x }.sort.reverse
  end

  def hand_with_stronger_x(left_x, right_x)
    for x in 0...left_x.length
      return left if left_x[x] > right_x[x]
      return right if left_x[x] < right_x[x]
    end
    compare_kickers
  end

end

# class FourOfAKind < CardGroups