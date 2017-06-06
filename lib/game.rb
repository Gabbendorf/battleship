require_relative 'ui'
require_relative 'grid'
require_relative 'player'
require_relative 'ships_list'
require_relative 'grid_display'
require_relative 'ship'

class Game

  def initialize
    @grid_display = GridDisplay.new
    @ui = Ui.new($stdin, $stdout, @grid_display)
    @grid = Grid.new
    @player1 = Player.new(@grid)
    @ships_list = ShipsList.new
  end

  def start
    @ui.welcome
    name = @ui.ask_name_player1
    place_ships_on_grid(name)
    ask_to_attack
  end

  def place_ships_on_grid(player_name)
    while @ships_list.ships.size > 0
      @ui.invite_to_select_ship_number(player_name)
      @ui.print_list_of_ships(@ships_list)
      ship = @ui.selected_ship
      @ships_list.delete_selected_ship(ship)
      coordinates_and_orientation_for(ship)
    end
  end

  def ask_to_attack
    attacker = @ui.ask_name_player2
    while !@grid.end_game?
      @ui.display_grid
      cell_to_attack = @ui.cell_to_attack(attacker)
      result = @player1.attack(cell_to_attack)
      hit_or_water(result, cell_to_attack)
    end
    @ui.declare_winner(attacker)
  end

  private

  def hit_or_water(result, cell_to_attack)
    if result == :hit
      @grid_display.hit(cell_to_attack)
      hit_ship = @grid.ship_on(cell_to_attack)
        if hit_ship.sunk?
          @grid_display.sunk(hit_ship.positions)  #=> need method for ship that returns its position
        end
    elsif result == :water
      @grid_display.water(cell_to_attack)
    end
  end

  def coordinates_and_orientation_for(ship)
    @ui.display_grid
    coordinates_and_orientation = @ui.coordinates_and_orientation
    @player1.place_ship(
      coordinates_and_orientation[:x],
      coordinates_and_orientation[:y],
      ship,
      coordinates_and_orientation[:orientation]
    )
  end

end
