require 'spec_helper'
require 'pitboss'

describe Pitboss::Score do
  
  it 'should make the best possible hand given a players hand and the community cards' do
    hand = %w{AS 3D}
    community_cards =%w{AD 3S 4C 7S 9D}
    
    best_hand = Pitboss::Score.best_hand(hand, community_cards)
    
    best_hand.should == PokerHand.new(%w{AS AD 3D 3S 9D})
  end

end
