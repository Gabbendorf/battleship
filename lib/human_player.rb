require_relative 'ships_list'
require_relative 'ui'
require_relative 'ship'
require_relative 'validated_ui'
require_relative 'ships_placer'

class HumanPlayer < ShipsPlacer

  attr_reader :name

  def initialize(name, grid, validated_ui, ui, ships_list)
    @ships_list = ships_list
    @name = name
    @grid = grid
    @validated_ui = validated_ui
    @ui = ui
  end

  def ship_placement
    ship = generate_ship
    position = generate_position(ship)
    ship.register_position(position[:x], position[:y], position[:orientation])
    ship
  end

  def ship_attack(player_name)
    @ui.display_grid
    @validated_ui.valid_cell_to_attack(player_name)
  end

  private

  def generate_ship
    @ships_list.prepare_ship(@validated_ui.selected_ship(@name, @ships_list))
  end

  def generate_position(ship)
    @ui.display_grid
    @validated_ui.valid_position(ship)
  end

end
