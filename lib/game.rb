require_relative 'player'
require_relative 'create_ship'

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
    ships_placement
    attacker = ships_attack
    end_game(attacker)
  end

  private

  def ships_placement
    rival = @ui.ask_to_choose_rival_type
    if rival == "computer"
      @computer.place_ship
      @ui.confirm_ships_were_placed
    else
      ships_owner = Player.new(@ui.ask_name_player1, @grid, @validated_ui, @ui)
      while @ships_list.ships.size > 0
        ship = ships_owner.placement_move(ships_owner.name, @ships_list, @ui)
        @grid.add_ship(ship)
      end
    end
  end

  #TODO: need to fix bug that let the game never end
  def ships_attack
    attacker = Player.new(@ui.ask_name_player2, @grid, @validated_ui, @ui)
    while !@grid.end_game?
      cell_to_attack = attacker.attack_move(attacker.name)
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
