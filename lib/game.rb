require_relative 'ui'
require_relative 'grid'
require_relative 'player'
require_relative 'ships_list'

class Game

  def initialize
    @ui = Ui.new($stdin, $stdout)
    @grid = Grid.new
    @player1 = Player.new(@grid)
    @ships_list = ShipsList.new
  end

  def start
    @ui.welcome
    name = @ui.ask_name_player1
    place_ships_on_grid(name)
    print_ships_placed
  end

  def place_ships_on_grid(player_name)
    while @ships_list.ships.size > 0
      @ui.invite_to_select_ship_number(player_name)
      @ui.print_list_of_ships(@ships_list)
      ship = @ui.selected_ship
      @ships_list.delete_selected_ship(ship)
      ask_to_choose_coordinates_and_orientation(ship)
    end
  end

  def ask_to_choose_coordinates_and_orientation(ship)
    @ui.display_grid
    coordinates_and_orientation = @ui.coordinates_and_orientation
    @player1.place_ship(
      coordinates_and_orientation[:x],
      coordinates_and_orientation[:y],
      ship,
      coordinates_and_orientation[:orientation]
    )
  end

  def print_ships_placed
    puts @grid.ships_placed
  end

end
