require 'ostruct'
module Pitboss
  class Game
    def initialize(options={})
      @debug = options[:debug]
    end
    
    def accept_bets
      while @active_players.size > 1
        puts "#{@active_players.size} are in, bets are #{@current_bets}" if @debug
        @active_players.each do |player|
          puts "...action to #{player.id}" if @debug
          action, amount = player.take_action({
            :players => @active_players.size,
            :current_high_bet => @current_high_bet, 
            :pot => @pot
          }) #todo pass current game status
          if action == :fold
            fold(player)
          elsif action == :bet
            #todo validate bet
            fold(player) if amount < @ante
            bet(player, amount)
          else
            # unknown action. you fold.
            fold(player)
          end
          if @active_players.size == 1
            @winners = @active_players
            throw :winner
          end
        end
        break unless @current_bets.values.uniq.size > 1
      end
    end
    
    def fold(player)
      @active_players -= [player]
      @current_bets.delete(player)
      puts "#{player.id} folds" if @debug
    end
    
    def bet(player, amount)
      @stacks[player] -= amount
      @pot += amount
      @current_bets[player] += amount
      @current_high_bet = amount if amount > @current_high_bet
      puts "#{player.id} bets $#{amount}" if @debug
    end

    def compare_cards
      scores = {}
      @active_players.each do |player|
        score = player.cards.value(@community_cards)
        scores[score] ||= []
        scores[score].push(player)
      end
      @winners = scores[scores.keys.max]
    end

    def deal
      catch :winner do
        @dealer = @players.shift
        @players.push(@dealer)
        @players.each { |player| player.cards.clear }
        @pot = 0
        @active_players = @players
        @current_high_bet = @ante = 2
        @current_bets = {}
        @players.each { |p| @current_bets[p] = 0 }

        if @players.size == 2
          @small_blind = @dealer
          @big_blind   = @players.first
        else
          @small_blind = @players.first
          @big_blind   = @players[1]
        end

        # Deal
        @deck = Deck.new
        2.times do
          @players.each do |player|
            player.cards.push(@deck.card!)
          end
        end

        if @debug
          puts "\nNEW GAME:"
          @players.each do |p| 
            if p == @dealer
              puts "D  #{p.id} #{p.cards} $#{@stacks[p]}" 
            elsif p == @small_blind
              puts "B  #{p.id} #{p.cards} $#{@stacks[p]}"
            elsif p == @big_blind
              puts "BB #{p.id} #{p.cards} $#{@stacks[p]}" 
            else
              puts "   #{p.id} #{p.cards} $#{@stacks[p]}"
            end
          end
        end

        # Small blind
        bet(@small_blind, @ante / 2)

        # Big blind
        bet(@big_blind, @ante)

        if @count.zero? && @players.size > 2
          2.times do
            p = @active_players.shift
            @active_players.push(p)
          end
        end

        # Accept pre-flop bets
        accept_bets

        # Flop
        @deck.burn!
        @community_cards = []
        3.times do
          @community_cards.push(@deck.card!)
        end

        if @debug
          puts "the flop..."
          @community_cards.each {|c| puts c}
        end

        # Accept bets again
        accept_bets

        # Turn
        @deck.burn!
        @community_cards.push(@deck.card!)

        if @debug
          puts "the turn..."
          puts @community_cards.last
        end

        # Accept bets again
        accept_bets

        # River card
        @deck.burn!
        @community_cards.push(@deck.card!)

        if @debug
          puts "the river..."
          puts @community_cards.last
        end

        # Accept bets again
        accept_bets

        # Compare cards!
        compare_cards
      end
      declare_winner
    end

    def dealer
      @dealer
    end

    def declare_winner
      puts "#{@winners.map(&:id).join(' and ')} #{@winners.size == 1 ? 'is' : 'are'} the winner#{'s' unless @winners.size == 1}! Beer for them!"
      #todo distribute @pot
    end

    def players
      @players
    end

    def shuffle_up_and_deal(chips=1000)
      raise "need at least 2 players" if @players.size < 2
      @players = @players.shuffle
      @stacks = {}
      @players.each { |p| @stacks[p] = chips }

      # Set the number of hands we've played to 0 - this will allow us to ensure the "first to act"
      # is the *third* person, and not the small blind, when @count is zero
      @count = 0
      3.times do #temporarily play 3 hands
        deal
      end
    end

    def sit(player)
      @players ||= []
      raise "'#{player.id}' has already been seated" if @players.any? {|p| p.id == player.id}
      @players.push(player)
    end
  end
end
