require 'spec_helper'
require 'pitboss'

describe Pitboss::Player do
  it "should have an ID in its initializer" do
    player = Pitboss::Player.new("flip_could_totally_hunt_ed")
    player.id.should == "flip_could_totally_hunt_ed"
  end

  it "should let me bet" do
    player = Pitboss::Player.new("seriously_he_wouldnt_last_three_minutes")
    player.bet! 20.00
    player.bet.should be_close 20.00, 0.0000001
  end

  it "should let me bet again, dude" do
    player = Pitboss::Player.new("seriously_he_wouldnt_last_three_minutes")
    player.bet! 20.00
    player.bet! 20.00
    player.bet.should be_close 40.00, 0.0000001
  end

end
