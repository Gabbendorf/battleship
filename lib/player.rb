require_relative 'create_ship'

class Player

  def initialize(grid)
    @grid = grid
    @create_ship = CreateShip.new
  end

  def place_ship(x, y, ship_name, orientation)
    @grid.mark_ship_positions(x, y, ship_from_name(ship_name), orientation)
  end

  def attack(cell_position)
    if @grid.ship?(cell_position)
    #   :water
    # else
    #   :hit
    end
  end

  private

  def ship_from_name(ship_name)
    @create_ship.ship_from_name(ship_name)
  end

end
