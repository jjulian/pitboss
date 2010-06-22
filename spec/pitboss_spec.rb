require 'spec_helper'
require 'pitboss'

describe Pitboss do
  before do
    @game = Pitboss::Game.new
  end
  it "should allow a player to sit" do
    @game.sit("player1")
    @game.players.size.should == 1
  end
  it "should not allow the game to start unless there are at least 2 players" do
    lambda { @game.shuffle_up_and_deal }.should raise_error(StandardError)
  end
end
