module Pitboss
  class Hand < Array
    def by_face
      @by_face ||= sort_by {|card| [card.face, card.suit] }.reverse.join(' ')
    end

    def by_suit
      @by_suit ||= sort_by {|card| [card.suit, card.face] }.reverse.join(' ')
    end

    # Find the highest value of the cards for now. We're not really worrying about what the
    # cards were or even what the status of the hand was - just give us a score and move on.
    def value(community_cards)
      full_hand = Hand.new(self + community_cards)
      %w(royal_flush straight_flush four_of_a_kind full_house flush straight three_of_a_kind two_pair pair highest_card).each do |match|
        if score = full_hand.send("#{match}?".to_sym)
          return score
        end
      end
    end

    # Scoring - in order of awesome, top to bottom. This is taken from Rob Olson's ruby-poker:
    # http://github.com/robolson/ruby-poker

    # Royal flush - Ace-King-Queen-Jack-Ten of the same suit
    def royal_flush?
      by_suit =~ /A(.) K\1 Q\1 J\1 T\1/ && 10
    end

    def straight_flush?
      return 9 if /.(.)(.)(?: 1.\2){4}/.match(delta_transform(true))
    end

    def four_of_a_kind?
      return 8 if by_face =~ /(.). \1. \1. \1./
    end

    def full_house?
      if by_face =~ /(.). \1. \1. (.*)(.). \3./ || by_face =~ /((.). \2.) (.*)((.). \5. \5.)/
        return 7
      end
    end

    def flush?
      return 6 if by_suit =~ /(.)(.) (.)\2 (.)\2 (.)\2 (.)\2/
    end

    def straight?
      result = false
      if size >= 5
        transform = delta_transform
        # note we can have more than one delta 0 that we
        # need to shuffle to the back of the hand
        i = 0
        until transform.match(/^\S{3}( [1-9x]\S\S)+( 0\S\S)*$/) || i >= size  do
          # only do this once per card in the hand to avoid entering an
          # infinite loop if all of the cards in the hand are the same
          transform.gsub!(/(\s0\S\S)(.*)/, "\\2\\1")    # moves the front card to the back of the string
          i += 1
        end
        if (md = (/.(.). 1.. 1.. 1.. 1../.match(transform)))
          return 5
        end
      end
    end

    def three_of_a_kind?
      return 4 if by_face =~ /(.). \1. \1./
    end

    def two_pair?
      return 3 if by_face =~ /(.). \1.(.*?) (.). \3./
    end

    # Does a pattern ever repeat, ever?
    def pair?
      return 2 if by_face =~ /(.). \1./
    end

    # Yeah, you always have a highest card
    def highest_card?
      1
    end


    # delta transform creates a version of the cards where the delta
    # between card values is in the string, so a regexp can then match a
    # straight and/or straight flush
    def delta_transform(use_suit = false)
      aces = select(&:ace?)
      # Let aces be high or low!
      if use_suit
        base = (self + aces).sort_by {|card| [card.suit, card.ace? ? 1 : card.face] }.reverse
      else
        base = (self + aces).sort_by {|card| [card.ace? ? 1 : card.face, card.suit] }.reverse
      end

      result = base.inject(['',nil]) do |(delta_hand, prev_card), card|
        if (prev_card)
          delta = prev_card - card.face
        else
          delta = 0
        end
        # does not really matter for my needs
        delta = 'x' if (delta > 9 || delta < 0)
        delta_hand += delta.to_s + card.to_s + ' '
        [delta_hand, card.face]
      end

      # we just want the delta transform, not the last cards face too
      result[0].chop
    end
  end
end
