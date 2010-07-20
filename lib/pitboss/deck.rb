module Pitboss
  class Deck
    def burn!
      card!
      # YOU GET NASSING, LEBOWSKI! NASSING!
      false
    end

    def card!
      @dealt ||= []
      card = @cards.pop
      @dealt.push(card)
      card
    end

    def cards
      @cards
    end

    def initialize
      @cards = %w(C D H S).map do |suit|
        ((2..9).to_a + %w(T J Q K A)).map {|card| Card.new("#{card}#{suit}") }
      end.flatten.uniq.knuth_shuffle!
    end
  end
end

# http://en.wikipedia.org/wiki/Fisher%E2%80%93Yates_shuffle
# ruby sourced from http://rosettacode.org/wiki/Knuth_shuffle#Ruby
class Array
  def knuth_shuffle!
    j = length
    i = 0
    while j > 1
      r = i + rand(j)
      self[i], self[r] = self[r], self[i]
      i += 1
      j -= 1
    end
    self
  end
end
