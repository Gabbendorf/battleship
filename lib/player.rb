require_relative 'ships_list'
require_relative 'ui'

class Player

  attr_reader :name

  def initialize(name, grid, validated_ui)
    @name = name
    @grid = grid
    @validated_ui = validated_ui
  end

  def placement_move(player_name, ships_list, ui)
    ship = ships_list.prepare_ship(@validated_ui.selected_ship(player_name, ships_list))
    ui.display_grid
    position = @validated_ui.valid_position(ship)
    ship.register_position(position[:x], position[:y], position[:orientation])
    ship
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
      @grid.register_sunk_ship(ship)
    end
  end

end
