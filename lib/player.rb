require_relative 'ship'

class Player

  def initialize(grid)
    @grid = grid
  end

  def place_ship(x,y,ship_name)
    @grid.mark_ship_positions(x,y,ship_from_name(ship_name))
  end

  def attack(cell_position)
    if !@grid.ship?(cell_position)
      :water
    else
      :hit
    end
  end

  private

  def ship_from_name(ship_name)
    case ship_name
    when "submarine"
      Ship.new("submarine", 1)
    when "destroyer"
      Ship.new("destroyer", 2)
    when "cruiser"
      Ship.new("cruiser", 3)
    when "aircraft-carrier"
      Ship.new("aircraft-carrier", 4)
    end
  end

end
