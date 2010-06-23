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

  describe "playing order" do
    before do
      @game.sit "p1"
      @game.sit "p2"
      @game.sit "p3"
      @game.shuffle_up_and_deal
    end

    it "should advance playing order in hand 2" do
      dealer_index = @game.players.index(@game.dealer)
      if dealer_index == @game.players.size - 1
        next_dealer = @game.players.first
      else
        next_dealer = @game.players[dealer_index.succ]
      end
      @game.deal
      @game.dealer.should == next_dealer
    end
  end


  context "when game has enough players" do

    before do
      @game.sit "p1"
      @game.sit "p2"
      @game.sit "p3"
      @game.sit "p4"
      @game.shuffle_up_and_deal
    end

    it "should make sure cards are different for each player" do
      all_cards = @game.players.map(&:cards)
      all_cards.uniq.size.should == 4
      all_cards.each do |cards|
        (all_cards - [cards]).each do |cards_2|
          (cards & cards_2).should be_empty
        end
      end
    end

    it "should deal cards that are valid" do
      @game.players.map(&:cards).each do |cards|
        cards.each do |card|
          card.should match(/[2-9TJQKA][CDHS]/)
        end
      end
    end

  end
end
