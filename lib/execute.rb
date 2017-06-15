require_relative 'game'
require_relative 'ui'
require_relative 'grid'
# require_relative 'player'
require_relative 'ships_list'
require_relative 'validations'
require_relative 'grid_display'
require_relative 'computer'

grid_display = GridDisplay.new
ui = Ui.new($stdin, $stdout, grid_display)
grid = Grid.new
# ships_owner = Player.new("Gabriella", grid)
# attacker = Player.new("Nic", grid)
ships_list = ShipsList.new
validations = Validations.new
computer = Computer.new(grid, ships_list, validations)
new_game = Game.new(grid_display, ui, grid, ships_list, validations, computer)

new_game.start
