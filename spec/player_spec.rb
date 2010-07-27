require 'spec_helper'
require 'pitboss'

describe Pitboss::Player do
  it "should have an ID in its initializer" do
    player = Pitboss::Player.new("flip_could_totally_hunt_ed")
    player.id.should == "flip_could_totally_hunt_ed"
  end

  it "should be able to take action"
end
