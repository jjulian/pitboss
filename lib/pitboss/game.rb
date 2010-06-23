require 'ostruct'
module Pitboss
  class Game
    def hands
      @hands
    end

    def players
      @players
    end

    def shuffle_up_and_deal
      raise "need at least 2 players" if @players.size < 2
      

      @hands = {}
      i = 0
      @deck = Deck.new
      2.times do
        @players.each do |player_id, player|
          @hands[player_id] ||= []
          # TODO: Extend to allow multiple poker types - currently assumes Texas Hold'em
          @hands[player_id].push(@deck.card!)
        end
      end
    end

    def sit(player)
      @players ||= {}
      raise "'#{player}' has already been seated" if @players.key?(player)
      @players[player] = player
    end
  end
end
