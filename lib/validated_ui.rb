require_relative 'ui'
require_relative 'ships_list'
require_relative 'grid'

class ValidatedUi

  def initialize(ui, ships_list, grid)
    @ui = ui
    @ships_list = ships_list
    @grid = grid
  end

  def selected_ship(player_name, list)
    ship_number = @ui.selected_ship(player_name, list)
    while @ships_list.validate(ship_number) == :invalid_ship_number
      ship_number = @ui.ask_for_valid_ship_number
    end
    @ships_list.convert_number_to_name(ship_number)
  end

  def valid_position(ship)
    position = @ui.coordinates_and_orientation
    validation_result = @grid.validate_placement(position, ship.length)
    while validation_result != :valid_position
      if validation_result == :invalid_ship_position
        position = @ui.ask_for_valid_position
      elsif validation_result == :invalid_placement
        position = @ui.ask_for_realistic_position
      end
      validation_result = @grid.validate_placement(position, ship.length)
    end
    position
  end

  def valid_cell_to_attack(attacker_name)
    cell_to_attack = @ui.cell_to_attack(attacker_name)
    while @grid.position_in_grid?(cell_to_attack[0], cell_to_attack[1]) == false
      cell_to_attack = @ui.ask_for_valid_position_to_attack
    end
    cell_to_attack
  end

end
