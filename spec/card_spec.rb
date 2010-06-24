require 'spec_helper'
require 'rubygems'


class Card

  private
  
  #patch: adds validation
  #TODO: find common entry point (this is not it)
  def build_from_face_suit(face, suit)
    raise ArgumentError.new("Invalid face (#{face})") unless FACE_VALUES.keys.include?(face.upcase)
    raise ArgumentError.new("Invalid suit (#{suit})") unless SUIT_LOOKUP.keys.include?(suit.downcase)
    suit.downcase!
    @face  = Card::face_value(face)
    @suit  = SUIT_LOOKUP[suit]
    @value = (@suit * FACES.size()) + (@face - 1)

  end

end

describe Card do
  describe "new" do
    it "should yell if the face is invalid" do
      lambda { Card.new("1S") }.should raise_error(ArgumentError)
    end

    it "should yell if the suit is invalid" do
      lambda { Card.new("2W") }.should raise_error(ArgumentError)
    end
  end
end

