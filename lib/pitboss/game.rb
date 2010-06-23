require 'ostruct'
module Pitboss
  class Game
    def ante
      @ante ||= 2.00
    end

    def deal
      @dealer = @players.shift
      @players.push(@dealer)

      if @players.size == 2
        small_blind = @dealer
        big_blind   = @players.first
      else
        small_blind = @players.first
        big_blind   = @players[1]
      end

      # Small blind
      small_blind.bet!(ante / 2.0)

      # Big blind
      big_blind.bet!(ante)

      if @count.zero? && @players.count > 2
        first_to_act = @players[2]
      else
        first_to_act = @players.first
      end

      # Deal
      @deck = Deck.new
      2.times do
        @players.each do |player|
          @deck.deal_to(player)
        end
      end

      @players.each do |player|
        player.accept_bet
      end

      # Burn one
      @deck.burn!

      # Flop
      @community_cards = []
      3.times do
        @community_cards.push(@deck.card!)
      end

      # Burn another
      @deck.burn!

      # Turn
      @community_cards.push(@deck.card!)

      # Burn another
      @deck.burn!

      # River card
      @community_cards.push(@deck.card!)
    end

    def dealer
      @dealer
    end

    def players
      @players
    end

    def shuffle_up_and_deal
      raise "need at least 2 players" if @players.size < 2
      @players = @players.shuffle

      # Set the number of hands we've played to 0 - this will allow us to ensure the "first to act"
      # is the *third* person, and not the small blind, when @count is zero
      @count = 0
      deal# while @players.size > 1
    end

    def sit(player_id)
      @players ||= []
      raise "'#{player_id}' has already been seated" if @players.any? {|player| player.id == player_id}
      @players.push(Player.new(player_id, self))
    end
  end
end
