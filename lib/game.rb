require_relative 'ui'
require_relative 'grid'
require_relative 'player'
require_relative 'ships_list'
require_relative 'grid_display'
require_relative 'ship'
require_relative 'validations'

class Game

  def initialize
    @grid_display = GridDisplay.new
    @ui = Ui.new($stdin, $stdout, @grid_display)
    @grid = Grid.new
    @player = Player.new(@grid)
    @ships_list = ShipsList.new
    @validations = Validations.new
  end

  def start
    @ui.welcome
    player1 = @ui.ask_name_player1
    ask_to_place_ships_on_grid(player1)
    player2 = @ui.ask_name_player2
    ask_to_attack(player2)
    end_game(player2)
  end

  def ask_to_place_ships_on_grid(player1_name)
    while @ships_list.ships.size > 0
      @ui.invite_to_select_ship_number(player1_name)
      @ui.print_list_of_ships(@ships_list)
      ship_number = @ui.selected_ship(@ships_list)
      while @validations.validate_ship_number(ship_number) == :invalid_ship_number
        ship_number = @ui.ask_for_valid_ship_number
      end
      ship = @ships_list.convert_number_to_name(ship_number)
      @ships_list.delete_selected_ship(ship)
      @ui.display_grid(@grid_display)
      player_places(ship)
    end
  end

  def ask_to_attack(player2_name)
    while !@grid.end_game?
      @ui.display_grid(@grid_display)
      cell_to_attack = @ui.cell_to_attack(player2_name)
      result = @player.attack(cell_to_attack)
      @grid_display.update_grid(result, cell_to_attack)
      check_if_sunk(cell_to_attack)
    end
  end

  def end_game(player2_name)
    @ui.display_grid(@grid_display)
    @ui.declare_winner(player2_name)
  end

  private

  def player_places(ship)
    position = @ui.coordinates_and_orientation
    puts position[:x]
    puts position[:y]
    puts ship
    puts position[:orientation]
    puts @grid.ships_placed
    while @validations.validate_position_for_ship(position) == :invalid_ship_position
      position = @ui.ask_for_valid_position
    end
    @player.place_ship(
      position[:x],
      position[:y],
      ship,
      position[:orientation]
    )
    puts position[:x]
    puts position[:y]
    puts ship
    puts position[:orientation]
    puts @grid.ships_placed
  end

  def check_if_sunk(cell_to_attack)
    hit_ship = @grid.ship_on(cell_to_attack)
    if hit_ship.sunk?
      sunk_ship_positions = hit_ship.occupied_cells(@grid)
      @grid_display.sunk(sunk_ship_positions)
    end
  end

end
