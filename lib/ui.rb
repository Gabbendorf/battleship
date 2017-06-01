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
    (1..9).each {|raw| grid << raw.to_s + dots + "\n"}
    grid << "10" + ".   " * 10 + "\n"
    @stdout.puts grid
  end

  def invite_to_select_ship_number(player1)
    @stdout.puts "#{player1}, choose a number for type of ship to place:"
  end

  def print_list_of_ships(list)
    list_number = 1
    list.ships.keys.each do |ship|
      @stdout.puts list_number.to_s + "- " + ship
      list_number += 1
    end
  end

  def selected_ship_number
    @stdin.gets.chomp.to_i
  end

  def ask_for_coordinates(ship)
    @stdout.puts "Where do you want to place the #{ship}? (choose 2 coordinates: X,Y)"
    @stdin.gets.chomp.split(",").map {|number| number.to_i}
  end

end
