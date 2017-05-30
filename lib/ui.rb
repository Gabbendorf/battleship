class Ui

  def initialize(stdin,stdout)
    @stdin = stdin
    @stdout = stdout
    @grid = Grid.new
  end

  def welcome
    @stdout.puts "Welcome to Battleship!"
  end

  def display_grid
    grid = "  "
    (1..10).each {|column| grid << column.to_s + "  "}
    grid << "\n"
    dots = ".  " * 10
    ("A ".."J " ).each {|raw| grid << raw + dots + "\n"}
    @stdout.puts grid
  end

  def invite_to_select_ship
    @stdout.puts "Player 1, choose a ship to place:"
  end

  def list_of_ships
    {'submarine' => 2,
     'destroyer' => 2,
     'cruise' => 1,
     'aircraft-carrier' => 1}
  end

  def print_list_of_ships
    list_of_ships.keys.each {|ship| @stdout.puts "- " + ship}
  end

  def selected_ship
    @stdin.gets.chomp
  end

  def ask_for_coordinates(ship)
    @stdout.puts "Where do you want to place the #{ship} (number,number)?"
  end

  def coordinates_for_ship
    @stdin.gets.chomp
  end

end
