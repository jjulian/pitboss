module Pitboss
  class Card < String
    def ace?
      face == 14
    end

    def face
      case self[0, 1].upcase
      when 'T'
        10
      when 'J'
        11
      when 'Q'
        12
      when 'K'
        13
      when 'A'
        14
      else
        self[0, 1].to_i
      end
    end

    def suit
      case self[1, 1].upcase
      when 'C'
        'Clubs'
      when 'D'
        'Diamonds'
      when 'H'
        'Hearts'
      when 'S'
        'Spades'
      end
    end
  end
end
