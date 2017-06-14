require_relative 'game'
require_relative 'ui'
require_relative 'grid'
require_relative 'player'
require_relative 'ships_list'
require_relative 'validations'
require_relative 'grid_display'
require_relative 'computer'

grid_display = GridDisplay.new
ui = Ui.new($stdin, $stdout, grid_display)
grid = Grid.new
player = Player.new(grid)
ships_list = ShipsList.new
validations = Validations.new
computer = Computer.new(grid, ships_list, validations)
new_game = Game.new(grid_display, ui, grid, player, ships_list, validations, computer)

new_game.start
