require 'rubygems'
require 'ruby-poker'

module Pitboss

  class Score

    def self.best_hand(hands, community_cards)
      best_combinations = []
      hands.each do | hand |
        arr = hand + community_cards
        permutations = []
        arr.perm(5){ |p| permutations << p}
        permutations.map!{|p| PokerHand.new(p)}
        permutations.sort! { |a,b| b <=> a}
        best_combinations << permutations.first
      end
      best_combinations.sort{ |a,b| b<=>a}.first
    end    

  end

end

class Array

  def perm(n = size)
    if size < n or n < 0
    elsif n == 0
      yield([])
    else
      self[1..-1].perm(n - 1) do |x|
	(0...n).each do |i|
	  yield(x[0...i] + [first] + x[i..-1])
	end
      end
      self[1..-1].perm(n) do |x|
	yield(x)
      end
    end
  end

end
