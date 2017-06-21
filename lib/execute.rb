require_relative 'game'
require_relative 'ui'
require_relative 'grid'
require_relative 'ships_list'
require_relative 'grid_display'
require_relative 'computer'
require_relative 'validated_ui'
require_relative 'create_ship'
require_relative 'ships_placer'

grid = Grid.new(10)
grid_display = GridDisplay.new(grid.size)
ui = Ui.new($stdin, $stdout, grid_display)
create_ship = CreateShip.new
ships_list = ShipsList.new(create_ship)
validated_ui = ValidatedUi.new(ui, grid)
computer = Computer.new(grid, ships_list)
new_game = Game.new(grid_display, ui, grid, ships_list, computer, validated_ui)

new_game.start
