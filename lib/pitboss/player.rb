module Pitboss
  class Player
    def bet!(amount)
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
      @bet = 0.0
    end
  end
end
