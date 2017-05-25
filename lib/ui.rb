  class Ui

    def initialize(stdin,stdout)
      @stdin = stdin
      @stdout = stdout
    end

    def welcome
      @stdout.puts "Welcome to Battleship. Are you ready to play?"
    end

    def invite_to_place_ship
      @stdout.puts "Player 1: place the first ship."
    end

    def display_grid
      grid = "  "
      (1..10).each {|column| grid << column.to_s + "  "}
      grid << "\n"
      dots = ".  " * 10
      ("A ".."J " ).each {|raw| grid << raw + dots + "\n"}
      @stdout.puts grid
    end

  end
