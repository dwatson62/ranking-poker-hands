class CardValues

  FACES = { 'T' => '10', 'J' => '11', 'Q' => '12', 'K' => '13', 'A' => '14' }

  def self.return_sorted_values(hand)
    hand.map { |card| FACES[card.chr] || card.chr }.sort
  end

  def self.compare_kickers(left, right)
    cards = left.length
    sorted_left = CardValues.return_sorted_values(left).reverse
    sorted_right = CardValues.return_sorted_values(right).reverse
    for x in 0..cards
      return left if sorted_left[x] > sorted_right[x]
      return right if sorted_left[x] < sorted_right[x]
    end
  end

end
