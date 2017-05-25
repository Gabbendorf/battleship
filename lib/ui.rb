  class Ui

    def initialize(stdin,stdout)
      @stdin = stdin
      @stdout = stdout
    end

    def welcome
      @stdout.puts "Welcome to Battleship. Are you ready to play?"
    end

    def invite_to_place_ships
      @stdout.puts "Player 1: place all the ships. Make sure Player 2 does not see."
    end

  end
