class Ui

  def initialize(stdin,stdout)
    @stdin = stdin
    @stdout = stdout
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

end
