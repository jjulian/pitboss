require 'spec_helper'
require 'pitboss'

describe Pitboss::Player do
  it "should have an ID in its initializer" do
    player = Pitboss::Player.new("flip_could_totally_hunt_ed", mock(:Game))
    player.id.should == "flip_could_totally_hunt_ed"
  end

  it "should have a game in its initializer" do
    game = mock(:Game)
    player = Pitboss::Player.new("seriously_he_wouldnt_last_three_minutes", game)
    player.game.should == game
  end

end
