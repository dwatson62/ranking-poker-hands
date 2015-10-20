class HandEvaluator

  attr_reader :left, :right

  CARDS = 5
  FACES = { 'J' => '11', 'Q' => '12', 'K' => '13', 'A' => '14' }

  def return_stronger_hand(left, right)
    set_hands(left, right)
    return hand_with_x_of_a_kind(4) if hand_with_x_of_a_kind(4) != nil
    return hand_with_x_of_a_kind(3) if hand_with_x_of_a_kind(3) != nil
    return hand_with_x_of_a_kind(2) if hand_with_x_of_a_kind(2) != nil
    compare_kickers
  end

  def set_hands(left, right)
    @left = left
    @right = right
  end

  def hand_with_x_of_a_kind(x)
    left_x_of_kind = get_x_of_a_kind(left, x)
    right_x_of_kind = get_x_of_a_kind(right, x)
    return if left_x_of_kind.length == 0 && right_x_of_kind.length == 0
    return left if left_x_of_kind.length > right_x_of_kind.length
    return right if left_x_of_kind.length < right_x_of_kind.length
    return hand_with_stronger_x(left_x_of_kind, right_x_of_kind)
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
    sorted_left = left.map { |x| x.chr }.sort.reverse
    sorted_right = right.map { |x| x.chr }.sort.reverse
    for x in 0..CARDS
      return left if sorted_left[x] > sorted_right[x]
      return right if sorted_left[x] < sorted_right[x]
    end
  end

end
