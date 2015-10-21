class HandEvaluator

  attr_reader :left, :right

  CARDS = 5
  FACES = { 'J' => '11', 'Q' => '12', 'K' => '13', 'A' => '14' }

  def return_stronger_hand(left, right)
    set_hands(left, right)
    return hand_with_straight_flush if hand_with_straight_flush
    return hand_with_x_of_a_kind(4) if hand_with_x_of_a_kind(4)
    return hand_with_full_house if hand_with_full_house
    return hand_with_flush if hand_with_flush
    return hand_with_straight if hand_with_straight
    return hand_with_x_of_a_kind(3) if hand_with_x_of_a_kind(3)
    return hand_with_x_of_a_kind(2) if hand_with_x_of_a_kind(2)
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

  def hand_with_full_house
    return left if check_full_house(left) && !check_full_house(right)
    return right if !check_full_house(left) && check_full_house(right)
    return compare_kickers if check_full_house(left) && check_full_house(right)
    nil
  end

  def check_full_house(hand)
    get_x_of_a_kind(hand, 3).any? && get_x_of_a_kind(hand, 2).any?
  end

  def hand_with_straight_flush
    return left if check_straight_flush(left) && !check_straight_flush(right)
    return right if !check_straight_flush(left) && check_straight_flush(right)
    return compare_kickers if check_straight_flush(left) && check_straight_flush(right)
    nil
  end

  def hand_with_flush
    check_ranking(Flush)
  end

  def hand_with_straight
    return left if check_straight(left) && !check_straight(right)
    return right if !check_straight(left) && check_straight(right)
    return compare_kickers if check_straight(left) && check_straight(right)
    nil
  end

  def check_straight_flush(hand)
    Flush.check(hand) && check_straight(hand)
  end

  def check_straight(hand)
    check_hand = adjust_values(hand)
    check_hand.each_cons(2).all? { |x, y| y == x.next }
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

class Straight

  def self.check(hand)
    check_hand = adjust_values(hand)
    check_hand.each_cons(2).all? { |x, y| y == x.next }
  end

end

# class FullHouse

#   def self.check(hand)
#     get_x_of_a_kind(hand, 3).any? && get_x_of_a_kind(hand, 2).any?
#   end

# end

class StraightFlush

  def self.check(hand)
    Flush.check(hand) && Straight.check(hand)
  end

end
