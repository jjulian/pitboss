require 'spec_helper'
require 'pitboss'

describe Pitboss::Deck do
  it "should have 52 cards" do
    deck = Pitboss::Deck.new
    deck.instance_variable_get(:@cards).size.should == 52
  end
end
