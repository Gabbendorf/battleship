class Game

  def initialize(grid_display, ui, grid, ships_list, validations, computer)
    @grid_display = grid_display
    @ui = ui
    @grid = grid
    @ships_list = ships_list
    @validations = validations
    @computer = computer
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
      position = valid_position(ship)
      ships_owner.place_ship(position[:x],
                         position[:y],
                         ship,
                         position[:orientation])
    end
  end

  def ships_attack(attacker)
    while !@grid.end_game?
      @ui.display_grid
      cell_to_attack = valid_cell_to_attack(attacker)
      result = attacker.attack(cell_to_attack)
      @grid_display.update_grid(result, cell_to_attack)
      check_if_sunk(cell_to_attack, result)
    end
  end

  def end_game(attacker)
    @ui.display_grid
    @ui.declare_winner(attacker.name)
  end

  def player1_selects_ship
    @ui.print_list_of_ships(@ships_list)
    ship_name = @ships_list.convert_number_to_name(valid_ship_number)
    @ships_list.delete_selected_ship(ship_name)
    @create_ship.ship_from_name(ship_name)
  end

  def valid_cell_to_attack(attacker)
    cell_to_attack = @ui.cell_to_attack(attacker.name)
    while @validations.validate_position_to_attack(cell_to_attack) == :invalid_attack
      cell_to_attack = @ui.ask_for_valid_position_to_attack
    end
    cell_to_attack
  end

  def valid_ship_number
    ship_number = @ui.selected_ship
    while @validations.validate_ship_number(ship_number, @ships_list) == :invalid_ship_number
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
