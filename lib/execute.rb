require_relative 'ui'
require_relative 'grid'
require_relative 'player'
require_relative 'ships_list'

ui = Ui.new($stdin, $stdout)
grid = Grid.new
player1 = Player.new(grid)
ships_list = ShipsList.new

ui.welcome
player1 = ui.ask_name_player1

while ships_list.ships.size > 0
  ui.invite_to_select_ship_number(player1)
  ui.print_list_of_ships(ships_list)
  ship = ships_list.convert_number_to_name(ui.selected_ship_number)
  ships_list.delete_selected_ship(ship)

  ui.display_grid
  ui.ask_for_coordinates(ship)
end
