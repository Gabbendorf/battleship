require_relative 'create_ship'
require_relative 'ship'

class Player

  attr_reader :name

  def initialize(name, grid)
    @name = name
    @grid = grid
    @grid_display = GridDisplay.new
    @create_ship = CreateShip.new
  end

  def place_ship(x, y, ship, orientation)
    @grid.mark_ship_positions(x, y, ship, orientation)
  end

  def attack(cell_position)
    ship = @grid.ship_on(cell_position)
    ship_exist?(ship) ? hit(cell_position, ship) : :water
  end

  private

  def ship_exist?(ship)
    ship != nil
  end

  def hit(cell_position, ship)
    ship.register_cells_hit(cell_position)
    update_sunk_ships_list(ship)
    :hit
  end

  def update_sunk_ships_list(ship)
    if ship.sunk?
      @grid.add_sunk_ship(ship)
    end
  end

end
