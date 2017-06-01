require_relative 'grid'
require_relative 'ships_list'

class Ui

  def initialize(stdin,stdout)
    @stdin = stdin
    @stdout = stdout
    @grid = Grid.new
    @ships_list = ShipsList.new
  end

  def welcome
    @stdout.puts "Welcome to Battleship!"
  end

  def ask_name_player1
    @stdout.puts "Player 1: enter your name"
    @stdin.gets.chomp
  end

  # def display_grid
  #   grid = "  "
  #   (1..10).each {|column| grid << column.to_s + "   "}
  #   grid << "\n"
  #   dots = " .  " * 10
  #   (1..10).each {|raw| grid << raw.to_s + dots + "\n"}
  #   @stdout.puts grid
  # end

  def invite_to_select_ship(player1)
    @stdout.puts "#{player1}, choose a number for type of ship to place:"
  end

  def print_list_of_ships
    list_number = 1
    @ships_list.ships.keys.each do |ship|
      @stdout.puts list_number.to_s + "- " + ship
      list_number += 1
    end
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
