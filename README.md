Ranking Poker Hands
=======================

## Synopsis

Original challenge from Upcase by Thoughtbot.

Challenge was to be given two poker hands and to return the winner. Hand rankings can be:

```
Straight Flush, Four of a Kind, Full House, Flush, Straight, Three of a Kind, Two Pair, Pair
```

Five cards are always dealt. In straights, Aces can be high or low.

My thinking in approaching this was to store the ranks in an array and to check each one in turn. Each checking method would return the best hand that met the conditions of that rank, or nil. If it returns nil, the program would carry on to the next rank. If the checking method returned a hand, the program would return at that point.

After noticing the similarities for each checking method, I used duck typing to inject most ranks as an object. The other ranks (such as three/four of a kind) uses the same method to find matching cards, with an argument passed in to denote how many to search for, so I used another duck for these based on a string name.

If I were to improve this, I would try to check all ranks in the same way, so that the return_strong_hand method only used one instance of duck typing, as opposed to two currently.

## Installation and Tests

```
git clone https://github.com/dwatson62/ranking-poker-hands
cd ranking-poker-hands
bundle
rspec
```

## Technologies Used

- Ruby
- Rspec
