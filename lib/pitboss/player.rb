module Pitboss
  class Player
    def accept_bet
      if @game.current_high_bet > bet
        bet! @game.current_high_bet - bet
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
    end

    def call!
      bet! 0.0
    end

    def cards
      @cards ||= []
    end

    def fold!
      @game.fold(self)
    end

    def game
      @game
    end

    def id
      @id
    end

    def initialize(id, game)
      @id = id
      @game = game
    end
  end
end
