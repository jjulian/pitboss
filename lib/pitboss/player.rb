module Pitboss
  class Player
    attr_reader :id
    
    def initialize(id)
      @id = id
    end

    #
    # todo implement AI here!
    #
    def take_action(game)
      @game = game
      if rand(100) < 50
        fold
      else
        bet(game[:current_high_bet])
      end
    end
    
    def to_s
      @id
    end

    #todo factor this out by holding cards at in the game
    def cards
      @cards ||= Hand.new
    end
    
    protected

    # Fold this hand
    def fold
      [:fold, nil]
    end

    # Place a bet - amount must be at least the "current bet"
    def bet(amount)
      [:bet, amount]
    end

  end
end
