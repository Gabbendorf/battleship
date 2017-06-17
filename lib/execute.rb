require_relative 'game'
require_relative 'ui'
require_relative 'grid'
require_relative 'ships_list'
require_relative 'validations'
require_relative 'grid_display'
require_relative 'computer'

grid = Grid.new(10)
grid_display = GridDisplay.new(grid.size)
ui = Ui.new($stdin, $stdout, grid_display)
ships_list = ShipsList.new
validations = Validations.new(grid_display)
computer = Computer.new(grid, ships_list, validations)
new_game = Game.new(grid_display, ui, grid, ships_list, validations, computer)

new_game.start
