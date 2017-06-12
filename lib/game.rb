class Game

  def initialize(grid_display, ui, grid, player, ships_list, validations)
    @grid_display = grid_display
    @ui = ui
    @grid = grid
    @player = player
    @ships_list = ships_list
    @validations = validations
    @create_ship = CreateShip.new
  end

  def start
    @ui.welcome
    player1 = @ui.ask_name_player1
    ships_placement(player1)
    player2 = @ui.ask_name_player2
    ships_attack(player2)
    end_game(player2)
  end

  def ships_placement(player1_name)
    while @ships_list.ships.size > 0
      @ui.invite_to_select_ship_number(player1_name)
      ship = player1_selects_ship
      @ui.display_grid
      position = valid_position(ship)
      @player.place_ship(position[:x],
                         position[:y],
                         ship,
                         position[:orientation])
    end
  end

  def ships_attack(player2_name)
    while !@grid.end_game?
      @ui.display_grid
      cell_to_attack = valid_cell_to_attack(player2_name)
      result = @player.attack(cell_to_attack)
      @grid_display.update_grid(result, cell_to_attack)
      check_if_sunk(cell_to_attack, result)
    end
  end

  def end_game(player2_name)
    @ui.display_grid
    @ui.declare_winner(player2_name)
  end

  private

  def player1_selects_ship
    @ui.print_list_of_ships(@ships_list)
    ship_name = @ships_list.convert_number_to_name(valid_ship_number)
    @ships_list.delete_selected_ship(ship_name)
    @create_ship.ship_from_name(ship_name)
  end

  def valid_cell_to_attack(player2_name)
    cell_to_attack = @ui.cell_to_attack(player2_name)
    while @validations.validate_position_to_attack(cell_to_attack) == :invalid_attack
      cell_to_attack = @ui.ask_for_valid_position_to_attack
    end
    cell_to_attack
  end

  def valid_ship_number
    ship_number = @ui.selected_ship(@ships_list)
    while @validations.validate_ship_number(ship_number) == :invalid_ship_number
      ship_number = @ui.ask_for_valid_ship_number
    end
    ship_number
  end

  def valid_position(ship)
    position = @ui.coordinates_and_orientation
    validation_result = @validations.validate_position_for_ship(ship, position)
    while validation_result != :valid_ship_position
      if validation_result == :invalid_ship_position
        position = @ui.ask_for_valid_position
      elsif validation_result == :invalid_placement
        position = @ui.ask_for_realistic_position
      end
      validation_result = @validations.validate_position_for_ship(ship, position)
    end
    position
  end

  def check_if_sunk(cell_to_attack, result)
    if result == :hit
      hit_ship = @grid.ship_on(cell_to_attack)
      if hit_ship.sunk?
        sunk_ship_positions = hit_ship.occupied_cells(@grid)
        @grid_display.sunk(sunk_ship_positions)
      end
    end
  end

end
