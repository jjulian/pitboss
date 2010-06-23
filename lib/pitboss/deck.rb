module Pitboss
  class Deck
    def burn!
      card!
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

    def deal_to(player)
      player.cards.push(card!)
    end

    def initialize
      @cards = %w(C D H S).map do |suit|
        ((2..9).to_a + %w(T J Q K A)).map {|card| "#{card}#{suit}" }
      end.flatten.uniq.shuffle
    end
  end
end
