require 'rubygems'
require 'ruby-poker'

module Pitboss

  class Score

    def self.best_hand(hand, community_cards)
      best_combinations = []
      arr = hand + community_cards

      permutations = [community_cards]
      permutations.concat(community_cards.combination(3).map{|h| h + hand})
      hand.each do |card|
        permutations.concat(community_cards.combination(4).map{|h| h << card})
      end

      permutations.map!{|p| PokerHand.new(p)}
      permutations.sort{ |a,b| b <=> a}.first
    end    

  end

end
