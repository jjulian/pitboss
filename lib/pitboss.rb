class Pitboss
  
  def players
    @players
  end
  
  def sit(player)
    @players ||= {}
    @players[player] = player
  end
  
end
