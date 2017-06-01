require_relative 'ui'
require_relative 'grid'
require_relative 'player'

ui = Ui.new($stdin, $stdout)
grid = Grid.new
player1 = Player.new("Gabriella", grid)

ui.welcome
player1 = ui.ask_name_player1
ui.invite_to_select_ship(player1)
ui.print_list_of_ships
ship = ui.selected_ship
ui.ask_for_coordinates(ship)
ui.display_grid
coordinates = ui.coordinates_for_ship
