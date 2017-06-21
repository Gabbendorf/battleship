require_relative 'human_player'
require_relative 'create_ship'
require_relative 'grid_display'
require_relative 'ui'
require_relative 'grid'
require_relative 'ships_list'
require_relative 'computer'
require_relative 'validated_ui'
require_relative 'ships_placer'

class Game

  def initialize(grid_display, ui, grid, ships_list, computer, validated_ui)
    @grid_display = grid_display
    @ui = ui
    @grid = grid
    @ships_list = ships_list
    @computer = computer
    @validated_ui = validated_ui
    @create_ship = CreateShip.new
  end

  def start
    @ui.welcome
    ships_placement(selected_ships_placer)
    attacker = ships_attack
    end_game(attacker)
  end

  private

  def selected_ships_placer
    rival = @ui.ask_to_choose_rival_type
    if rival == "computer"
      ships_placer = @computer
    else
      ships_placer = HumanPlayer.new(@ui.ask_name_player1, @grid, @validated_ui, @ui, @ships_list)
    end
  end

  def ships_placement(ships_placer)
    while @ships_list.ships.size > 0
      ship = ships_placer.ship_placement
      @grid.add_ship(ship)
    end
    @ui.confirm_ships_were_placed
  end

  def ships_attack
    attacker = HumanPlayer.new(@ui.ask_name_player2, @grid, @validated_ui, @ui, @ships_list)
    while !@grid.end_game?
      cell_to_attack = attacker.ship_attack(attacker.name)
      result = @grid.show_result(cell_to_attack)
      @grid_display.update_grid(result, cell_to_attack, @grid)
    end
    attacker
  end

  def end_game(attacker)
    @ui.display_grid
    @ui.declare_winner(attacker.name)
  end

end
