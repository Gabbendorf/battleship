require_relative 'ui'
require_relative 'ships_list'

class ValidatedUi

  def initialize(ui, ships_list)
    @ui = ui
    @ships_list = ships_list
  end

  def selected_ship
    ship_number = @ui.selected_ship
    while @ships_list.validate(ship_number) == :invalid_ship_number
      ship_number = @ui.ask_for_valid_ship_number
    end
    ship_number
  end

end
