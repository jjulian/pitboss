require 'spec_helper'
require 'pitboss'

describe Pitboss::Game do

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

  it "should not allow me to sit identical players" do
    @game.sit("player1")
    lambda {
      @game.sit("player1")
    }.should raise_error(StandardError, "'player1' has already been seated")
  end

  context "when game has enough players" do

    before do
      @game.sit "p1"
      @game.sit "p2"
      @game.sit "p3"
      @game.sit "p4"
      @game.shuffle_up_and_deal
    end

    it "should shuffle cards" do
      @game.hands.size.should == 4
    end

    it "should make sure cards are different for each player" do
      @game.hands.values.uniq.size.should == 4
      @game.hands.each do |player, hand|
        (@game.hands.values - [hand]).each do |hand_2|
          (hand & hand_2).should be_empty
        end
      end
    end

    it "should deal cards that are valid" do
      @game.hands.values.each do |hand|
        hand.each do |card|
          card.should match(/[2-9TJQKA][CDHS]/)
        end
      end
    end

  end
end
