require_relative 'ui'
require_relative 'grid'
require_relative 'game'

ui = Ui.new($stdin, $stdout)
grid = Grid.new
game = Game.new(grid)

ui.welcome
ui.invite_to_select_ship
ui.print_list_of_ships
ship = ui.selected_ship
ui.ask_for_coordinates(ship)
coordinates = ui.coordinates_for_ship
