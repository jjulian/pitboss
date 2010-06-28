module Pitboss
  class Player
    def accept_bet(current_high_bet)
      if current_high_bet > bet
        bet! current_high_bet - bet
      elsif rand(2) == 1
        fold!
      else
        call!
      end
    end

    def bet
      @bet ||= 0.0
    end

    def bet!(amount)
      @bet ||= 0
      @bet += amount
      amount
    end

    def call!
      bet! 0.0
    end

    def cards
      @cards ||= Hand.new
    end

    # Return false - the game will assume that means "no bet, dude"
    def fold!
      false
    end

    def id
      @id
    end

    def initialize(id)
      @id = id
    end
  end
end
