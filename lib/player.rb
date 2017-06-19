require_relative 'ships_list'
require_relative 'ui'
require_relative 'ship'
require_relative 'validated_ui'

class Player

  attr_reader :name

  def initialize(name, grid, validated_ui, ui)
    @name = name
    @grid = grid
    @validated_ui = validated_ui
    @ui = ui
  end

  def placement_move(player_name, ships_list, ui)
    ship = ships_list.prepare_ship(@validated_ui.selected_ship(player_name, ships_list))
    @ui.display_grid
    position = @validated_ui.valid_position(ship)
    ship.register_position(position[:x], position[:y], position[:orientation])
    ship
  end

  def attack_move(player_name)
    @ui.display_grid
    @validated_ui.valid_cell_to_attack(player_name)
  end

end
