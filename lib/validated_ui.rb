require_relative 'ui'
require_relative 'ships_list'
require_relative 'grid'

class ValidatedUi

  def initialize(ui, ships_list, grid)
    @ui = ui
    @ships_list = ships_list
    @grid = grid
  end

  def selected_ship
    ship_number = @ui.selected_ship
    while @ships_list.validate(ship_number) == :invalid_ship_number
      ship_number = @ui.ask_for_valid_ship_number
    end
    ship_number
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

end
