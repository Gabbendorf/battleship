require 'spec_helper'
require_relative '../lib/ui'

RSpec.describe Ui do

  let(:grid_display) {GridDisplay.new}
  let(:input) {StringIO.new}
  let(:output) {StringIO.new}
  let(:ui) {Ui.new(input, output, grid_display)}
  let(:ship) {Ship.new}
  let(:ships_list) {ShipsList.new}
  let(:grid) {Grid.new}
  let(:ships_owner) {Player.new("Gabriella", grid)}
  let(:attacker) {Player.new("Nic", grid)}

  it "welcomes the players" do
    ui.welcome

    expect(output.string).to include("Welcome to Battleship!")
  end

  it "asks player to choose between human player or computer to play against" do
    input = StringIO.new("Computer")
    ui = Ui.new(input, output, grid_display)

    rival = ui.ask_to_choose_rival_type

    expect(output.string).to include("Do you want to play against human player or computer?")
    expect(rival).to eq("computer")
  end

  it "confirms computer placed all ships" do
    ui.confirm_ships_were_placed

    expect(output.string).to include("Computer placed all ships.")
  end

  it "asks for name of player 1" do
    input = StringIO.new(ships_owner.name)
    ui = Ui.new(input, output, grid_display)

    player_name = ui.ask_name_player1

    expect(output.string).to include("Player 1: enter your name")
    expect(player_name).to eq("Gabriella")
  end

  it "displays the grid" do
    ui.display_grid

    expect(output.string).to include("       1   2   3   4   5   6   7   8   9   10   \n   A   .   .   .   .   .   .   .   .   .   .   \n   B   .   .   .   .   .   .   .   .   .   .   \n   C   .   .   .   .   .   .   .   .   .   .   \n   D   .   .   .   .   .   .   .   .   .   .   \n   E   .   .   .   .   .   .   .   .   .   .   \n   F   .   .   .   .   .   .   .   .   .   .   \n   G   .   .   .   .   .   .   .   .   .   .   \n   H   .   .   .   .   .   .   .   .   .   .   \n   I   .   .   .   .   .   .   .   .   .   .   \n   J   .   .   .   .   .   .   .   .   .   .   \n")

  end

  it "invites player 1 to choose number for ship to place" do
    ui.invite_to_select_ship_number(ships_owner.name)

    expect(output.string).to include("Gabriella, choose a number for ship to place:")
  end

  it "prints the list of ships to be placed" do
    ui.print_list_of_ships(ships_list)

    expect(output.string).to include("1- submarine\n2- destroyer\n3- cruiser\n4- aircraft-carrier\n")
  end

  it "registers selected ship" do
    input = StringIO.new("1")
    ui = Ui.new(input, output, grid_display)

    ship = ui.selected_ship

    expect(ship).to eq(1)
  end

  it "asks for coordinates and orientation to place ship, checks it and returns hash" do
    input = StringIO.new("1,a,v")
    ui = Ui.new(input, output, grid_display)

    coordinates_and_orientation = ui.coordinates_and_orientation

    expect(output.string).to include("Choose 2 coordinates X,Y and an orientation h for 'horizontal' or v for 'vertical' (ex. 2,b,h)")
    expect(coordinates_and_orientation).to eq({:x => 1, :y=> "A", :orientation => :vertical})
  end

  it "asks for coordinates and orientation to place ship, checks them and returns hash with invalid values if invalid input" do
    input = StringIO.new("1,a,")
    ui = Ui.new(input, output, grid_display)

    coordinates_and_orientation = ui.coordinates_and_orientation

    expect(output.string).to include("Choose 2 coordinates X,Y and an orientation h for 'horizontal' or v for 'vertical' (ex. 2,b,h)")
    expect(coordinates_and_orientation).to eq({:x => 0, :y=> "", :orientation => nil})
  end

  it "asks for name of player 2" do
    input = StringIO.new("Gabriella")
    ui = Ui.new(input, output, grid_display)

    player_name = ui.ask_name_player2

    expect(output.string).to include("Player 2: enter your name")
    expect(player_name).to eq("Gabriella")
  end

  it "asks for coordinates x,y to attack, checks them and returns array" do
    input = StringIO.new("1,a")
    ui = Ui.new(input, output, grid_display)

    cell_to_attack = ui.cell_to_attack(attacker.name)

    expect(output.string).to include("Nic, where do you want to attack (ex. 3,b)?")
    expect(cell_to_attack).to eq([1, "A"])
  end

  it "asks for coordinates x,y to attack, checks them and returns array with invalid elements if invalid input" do
    input = StringIO.new("1,")
    ui = Ui.new(input, output, grid_display)

    cell_to_attack = ui.cell_to_attack(attacker.name)

    expect(output.string).to include("Nic, where do you want to attack (ex. 3,b)?")
    expect(cell_to_attack).to eq([0, ""])
  end

  it "declares a winner" do
    ui.declare_winner(attacker.name)

    expect(output.string).to include("Congratulations Nic: YOU WON!")
  end

  it "prints message for wrong ship number and asks for new number" do
    input = StringIO.new("2\n")
    ui = Ui.new(input, output, grid_display)

    number = ui.ask_for_valid_ship_number

    expect(output.string).to include("Not valid number:")
    expect(number).to eq(2)
  end

  it "asks again for valid position for ship placement, checks it and returns hash" do
    input = StringIO.new("1,a,h\n")
    ui = Ui.new(input, output, grid_display)

    position = ui.ask_for_valid_position

    expect(output.string).to include("Not valid position:")
    expect(position).to eq({:x => 1, :y => "A", :orientation => :horizontal})
  end

  it "asks again for valid position for ship placement, checks it and returns hash with invalid values if invalid input" do
    input = StringIO.new("\n")
    ui = Ui.new(input, output, grid_display)

    position = ui.ask_for_valid_position

    expect(output.string).to include("Not valid position:")
    expect(position).to eq({:x => 0, :y => "", :orientation => nil})
  end

  it "asks for new position if ship goes outside grid, checks it and returns hash" do
    input = StringIO.new("1,a,v\n")
    ui = Ui.new(input, output, grid_display)

    position = ui.ask_for_realistic_position

    expect(output.string).to include("Ship could not be placed")
    expect(position).to eq({:x => 1, :y=> "A", :orientation => :vertical})
  end

  it "asks for new position if ship goes outside grid, checks it and returns hash with invalid values if invalid input" do
    input = StringIO.new("1\n")
    ui = Ui.new(input, output, grid_display)

    position = ui.ask_for_realistic_position

    expect(output.string).to include("Ship could not be placed")
    expect(position).to eq({:x => 0, :y=> "", :orientation => nil})
  end

  it "asks for valid position to attack, checks it and returns array" do
    input = StringIO.new("1,a\n")
    ui = Ui.new(input, output, grid_display)

    cell_to_attack = ui.ask_for_valid_position_to_attack

    expect(output.string).to include("Not valid position:")
    expect(cell_to_attack).to eq([1, "A"])
  end

  it "asks for valid position to attack, checks it and returns array with invalid elements if invalid input" do
    input = StringIO.new("1a\n")
    ui = Ui.new(input, output, grid_display)

    cell_to_attack = ui.ask_for_valid_position_to_attack

    expect(output.string).to include("Not valid position:")
    expect(cell_to_attack).to eq([0, ""])
  end

end
