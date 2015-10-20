class HandEvaluator

  attr_reader :left, :right, :left_pairs, :right_pairs

  FACES = {
    'J' => '11', 'Q' => '12', 'K' => '13', 'A' => '14'
  }

  def return_stronger_hand(left, right)
    set_hands(left, right)
    set_pairs
    p left_pairs
    p right_pairs
    return_hand_with_best_pairs
  end

  def set_hands(left, right)
    @left = left
    @right = right
  end

  def set_pairs
    @left_pairs = check_for_pairs(left)
    @right_pairs = check_for_pairs(right)
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

  def check_for_pairs(hand)
    pairs = hand.map { |x| x.chr }
    pairs.select { |x| pairs.count(x) > 1 }.sort.reverse.uniq
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
    for x in 0...left.length
      return left if left[x].chr > right[x].chr
      return right if left[x].chr < right[x].chr
    end
    nil
  end

end
