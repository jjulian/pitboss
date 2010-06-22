module Pitboss
  class Deck
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
        ((2..9).to_a + %w(T J Q K A)).map {|card| "#{card}#{suit}" }
      end.flatten.uniq.shuffle
    end
  end
end
