require 'spec_helper'
require 'pitboss'

describe Pitboss do
  before do
    @pitboss = Pitboss.new
  end
  it "should allow a player to sit" do
    @pitboss.sit("player1")
    @pitboss.players.size.should == 1
  end
end
