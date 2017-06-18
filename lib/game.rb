require_relative 'player'

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
    rival = @ui.ask_to_choose_rival_type
    human_or_computer_place_ships(rival)
    attacker = Player.new(@ui.ask_name_player2, @grid)
    ships_attack(attacker)
    end_game(attacker)
  end

  private

  def human_or_computer_place_ships(rival)
    if rival == "computer"
      @computer.place_ship
      @ui.confirm_ships_were_placed
    else
      ships_owner = Player.new(@ui.ask_name_player1, @grid)
      ships_placement(ships_owner)
    end
  end

  def ships_placement(ships_owner)
    while @ships_list.ships.size > 0
      @ui.invite_to_select_ship_number(ships_owner.name)
      ship = player1_selects_ship
      @ui.display_grid
      position = @validated_ui.valid_position(ship)
      ships_owner.place_ship(position[:x],
                         position[:y],
                         ship,
                         position[:orientation])
    end
  end

  def player1_selects_ship
    @ui.print_list_of_ships(@ships_list)
    @ships_list.prepare_ship(@validated_ui.selected_ship)
  end

  def ships_attack(attacker)
    while !@grid.end_game?
      @ui.display_grid
      cell_to_attack = @validated_ui.valid_cell_to_attack(attacker.name)
      result = attacker.attack(cell_to_attack)
      @grid_display.update_grid(result, cell_to_attack)
      check_if_sunk(cell_to_attack, result)
    end
  end

  def check_if_sunk(cell_to_attack, result)
    if result == :hit
      hit_ship = @grid.ship_on(cell_to_attack)
      if hit_ship.sunk?
        sunk_ship_positions = hit_ship.occupied_cells
        @grid_display.sunk(sunk_ship_positions)
      end
    end
  end

  def end_game(attacker)
    @ui.display_grid
    @ui.declare_winner(attacker.name)
  end

end
