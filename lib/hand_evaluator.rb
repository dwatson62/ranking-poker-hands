class HandEvaluator

  attr_reader :left, :right, :left_pairs, :right_pairs

  CARDS = 5

  FACES = {
    'J' => '11', 'Q' => '12', 'K' => '13', 'A' => '14'
  }

  def return_stronger_hand(left, right)
    set_hands(left, right)
    set_pairs
    return hand_with_x_of_a_kind(4) if hand_with_x_of_a_kind(4) != nil
    return hand_with_x_of_a_kind(3) if hand_with_x_of_a_kind(3) != nil
    return_hand_with_best_pairs
  end

  def set_hands(left, right)
    @left = left
    @right = right
  end

  def set_pairs
    @left_pairs = get_pairs(left)
    @right_pairs = get_pairs(right)
  end

  def hand_with_x_of_a_kind(x)
    if look_for_x_of_a_kind(x, left_pairs) && look_for_x_of_a_kind(x, right_pairs)
      # check for kickers or full house
      return compare_kickers
    elsif look_for_x_of_a_kind(x, left_pairs)
      return left
    elsif look_for_x_of_a_kind(x, right_pairs)
      return right
    end
    nil
  end

  def look_for_x_of_a_kind(x, hand_pairs)
    hand_pairs.uniq.each { |element| return true if hand_pairs.count(element) == x }
    false
  end

  def return_hand_with_best_pairs
    return most_pairs if most_pairs != nil
    return_hand_with_stronger_pairs
  end

  def most_pairs
    return left if left_pairs.length > right_pairs.length
    right if right_pairs.length > left_pairs.length
  end

  def return_hand_with_stronger_pairs
    return compare_pairs if compare_pairs != nil
    compare_kickers
  end

  def get_pairs(hand)
    pairs = hand.map { |x| x.chr }
    pairs.select { |x| pairs.count(x) > 1 }.sort.reverse
  end

  def check_for_face(hand)
    hand.map { |x| x[0] = FACES[x.chr] if FACES.key?(x.chr) }
    hand
  end

  def compare_pairs
    for x in 0...left_pairs.length
      return left if left_pairs[x] > right_pairs[x]
      return right if left_pairs[x] < right_pairs[x]
    end
    nil
  end

  def compare_kickers
    for x in 0..CARDS
      return left if left[x].chr > right[x].chr
      return right if left[x].chr < right[x].chr
    end
    nil
  end

end
