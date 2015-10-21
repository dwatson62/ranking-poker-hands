class HandEvaluator

  attr_reader :left, :right, :ranks

  CARDS = 5
  FACES = { 'J' => '11', 'Q' => '12', 'K' => '13', 'A' => '14' }

  def return_stronger_hand(left, right)
    setup(left, right)
    ranks.each do |rank|
      if rank.class == String
        return check_x_of_a_kind(rank.chr.to_i) if check_x_of_a_kind(rank.chr.to_i)
      else
        return check_ranking(rank) if check_ranking(rank)
      end
    end
    compare_kickers
  end

  def setup(left, right)
    @left, @right = left, right
    @ranks = [StraightFlush, '4OfAKind', FullHouse, Flush,
              Straight, '3OfAKind', '2Pair', '2OfAKind']
  end

  def check_ranking(rank)
    return left if rank.check(left) && !rank.check(right)
    return right if !rank.check(left) && rank.check(right)
    compare_kickers if rank.check(left) && rank.check(right)
  end

  def check_x_of_a_kind(x)
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
    for i in 0...left_x.length
      return left if left_x[i] > right_x[i]
      return right if left_x[i] < right_x[i]
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

  def adjust_values(hand)
    card_numbers = hand.map { |card| card[0...-1] }
    card_numbers.map { |number| FACES[number] || number }.sort
  end

end

class Flush < HandEvaluator
  def self.check(hand)
    suit = hand[0][1]
    hand.select { |card| card[1] == suit }.length == CARDS
  end
end

class Straight < HandEvaluator
  def self.check(hand)
    numbers = hand.map { |card| card[0...-1] }
    numbers.map { |x| FACES[x] || x }.sort.each_cons(2).all? { |x, y| y == x.next }
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
