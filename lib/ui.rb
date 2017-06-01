require_relative 'grid'

class Ui

  def initialize(stdin,stdout)
    @stdin = stdin
    @stdout = stdout
    @grid = Grid.new
  end

  def welcome
    @stdout.puts "Welcome to Battleship!"
  end

  def ask_name_player1
    @stdout.puts "Player 1: enter your name"
    @stdin.gets.chomp
  end

  def display_grid
    grid = "  "
    (1..10).each {|column| grid << column.to_s + "   "}
    grid << "\n"
    dots = " .  " * 10
    (1..10).each {|raw| grid << raw.to_s + dots + "\n"}
    @stdout.puts grid
  end

  def invite_to_select_ship(player1)
    @stdout.puts "#{player1}, choose a ship to place:"
  end

  def print_list_of_ships
    @grid.list_of_ships.keys.each {|ship| @stdout.puts "- " + ship}
  end

  def selected_ship
    @stdin.gets.chomp
  end

  def ask_for_coordinates(ship)
    @stdout.puts "Where do you want to place the #{ship} (choose 2 coordinates: X,Y)?"
  end

  def coordinates_for_ship
    @stdin.gets.chomp
  end

end
