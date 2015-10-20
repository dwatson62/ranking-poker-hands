class HandEvaluator
  def return_stronger_hand(left, right)
    return left if check_for_pair(left) > check_for_pair(right)
    right
  end

  def check_for_pair(hand)
    hand = hand.join.chars
    answer = hand.select { |x| x =~ /[0-9]/ && hand.count(x) > 1 }
    answer[0] || '0'
  end
end
