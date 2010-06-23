module Pitboss
  class Player
    def accept_bet
      bet! @game.ante
    end

    def bet
      @bet ||= 0.0
    end

    def bet!(amount)
      @bet ||= 0
      @bet += amount
    end

    def cards
      @cards ||= []
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
