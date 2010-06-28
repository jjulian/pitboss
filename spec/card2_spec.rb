require 'spec_helper'
require 'pitboss/card'

describe Pitboss::Card do
  it "should have a suit and a face" do
    card = Pitboss::Card.new("TH")
    card.suit.should == 'Hearts'
    card.face.should == 10
  end
end
