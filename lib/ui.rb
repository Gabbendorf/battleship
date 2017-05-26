class Ui

  def initialize(stdin,stdout)
    @stdin = stdin
    @stdout = stdout
    @ships = Ships.new
  end

  def welcome
    @stdout.puts "Welcome to Battleship. Are you ready to play?"
  end

  def display_grid
    grid = "  "
    (1..10).each {|column| grid << column.to_s + "  "}
    grid << "\n"
    dots = ".  " * 10
    ("A ".."J " ).each {|raw| grid << raw + dots + "\n"}
    @stdout.puts grid
  end

  def invite_to_choose_ship
    @stdout.puts "Player 1: choose a ship to place."
  end

  def ships
    @ships.list_of_ships.each {|ship| @stdout.puts "- " + ship + "\n"}
  end

  def get_ship
    @stdin.gets
  end

end
