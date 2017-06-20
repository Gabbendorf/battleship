class ShipsPlacer

  def initialize(name)
    @name = name
  end

  # def create_ships_placer(rival_type)
  #   if rival_type == "computer"
  #     Computer.new()
  #   else
  #     HumanPlayer.new()
  #   end
  # end

  def ships_placement(position)
    ship.register_position(position[:x], position[:y], position[:orientation])
    @grid.add_ship
  end


end
