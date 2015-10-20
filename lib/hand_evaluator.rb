class HandEvaluator
  def return_stronger_hand(left, right)
    return left if check_for_pair(left) > check_for_pair(right)
    return right if check_for_pair(left) < check_for_pair(right)
    return left if check_for_kicker(left) > check_for_kicker(right)
    return right if check_for_kicker(left) < check_for_kicker(right)
  end

  def check_for_pair(hand)
    hand = hand.join.chars
    answer = hand.select { |x| x =~ /[0-9]/ && hand.count(x) > 1 }
    answer[0] || '0'
  end

  def check_for_kicker(hand)
    hand.sort.reverse.first.chr
  end
end
