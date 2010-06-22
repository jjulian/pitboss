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

  context "when game has enough players" do

    before do
      @game.sit "p1"
      @game.sit "p2"
      @game.sit "p3"
      @game.sit "p4"
    end

    it "should shuffle cards" do
      @game.shuffle_up_and_deal
      @game.hands.size.should == 4
    end

  end
end
