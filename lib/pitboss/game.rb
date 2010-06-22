module Pitboss
  class Game

    def players
      @players
    end

    def hands
      @hands
    end

    def sit(player)
      @players ||= {}
      @players[player] = player
    end

    def shuffle_up_and_deal
      raise "need at least 2 players" if @players.size < 2
      @hands ||= {}
      @players.each do |player|
        @hands[player] = 0
      end
    end
  end
end
