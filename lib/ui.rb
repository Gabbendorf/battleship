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
    ("A".."J").each {|raw| grid << raw.to_s + dots + "\n"}
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

  def selected_ship
    ship_number = @stdin.gets.chomp.to_i
    ShipsList.new.convert_number_to_name(ship_number)
  end

  def coordinates_and_orientation
    @stdout.puts "Choose 2 coordinates X,Y and an orientation 'horizontal' or 'vertical' (ex. 2,b,vertical)"
    input = @stdin.gets.chomp.split(",")
    {:x => input[0].to_i, :y => input[1].capitalize, :orientation => input[2]}
  end

  def ask_name_player2
    @stdout.puts "Player 2: enter your name"
    @stdin.gets.chomp
  end

end
