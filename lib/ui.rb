class Ui

  def initialize(stdin, stdout, grid_display)
    @stdin = stdin
    @stdout = stdout
    @grid_display = grid_display
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
    @stdout.puts @grid_display.grid.join("   ")
  end

  def invite_to_select_ship_number(player1)
    @stdout.puts "#{player1}, choose a number for ship to place:"
  end

  def print_list_of_ships(list)
    list_number = 1
    list.ships.keys.each do |ship|
      @stdout.puts list_number.to_s + "- " + ship
      list_number += 1
    end
  end

  def selected_ship(ships_list)
    @stdin.gets.chomp.to_i
  end

  def coordinates_and_orientation
    @stdout.puts "Choose 2 coordinates X,Y and an orientation h for 'horizontal' or v for 'vertical' (ex. 2,b,h)"
    input = @stdin.gets.chomp.split(",")
    details_for(input)
  end

  def ask_name_player2
    @stdout.puts "Player 2: enter your name"
    @stdin.gets.chomp
  end

  def cell_to_attack(player_name)
    @stdout.puts "#{player_name}, where do you want to attack (ex. 3,b)?"
    input = @stdin.gets.chomp.split(",")
    [input[0].to_i, input[1].capitalize]
  end

  def declare_winner(player_name)
    @stdout.puts "Congratulations #{player_name}: YOU WON!"
  end

  def ask_for_valid_ship_number
    @stdout.puts "Not valid number:"
    @stdin.gets.chomp.to_i
  end

  def ask_for_valid_position
    @stdout.puts "Not valid position:"
    input = @stdin.gets.chomp.split(",")
    details_for(input)
  end

  def ask_for_realistic_position
    @stdout.puts "Ship could not be placed"
    input = @stdin.gets.chomp.split(",")
    details_for(input)
  end

  def ask_for_valid_position_to_attack
    @stdout.puts "Not valid position:"
    input = @stdin.gets.chomp.split(",")
    [input[0].to_i, input[1].capitalize]
  end

  private

  def details_for(input)
    if input[2] == "v"
      orientation_symbol = :vertical
    elsif input[2] == "h"
      orientation_symbol = :horizontal
    end
    {:x => input[0].to_i, :y => input[1].capitalize, :orientation => orientation_symbol}
  end
end
