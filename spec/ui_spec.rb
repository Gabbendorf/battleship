require 'spec_helper'
require_relative '../lib/ui'
require_relative '../lib/grid_display'
require_relative '../lib/grid'
require_relative '../lib/human_player'
require_relative '../lib/ship'
require_relative '../lib/create_ship'
require_relative '../lib/ships_list'
require_relative '../lib/validated_ui'

RSpec.describe Ui do

  let(:grid) {Grid.new(10)}
  let(:grid_display) {GridDisplay.new(grid.size)}
  let(:input) {StringIO.new}
  let(:output) {StringIO.new}
  let(:ui) {Ui.new(input, output, grid_display)}
  let(:ship) {Ship.new}
  let(:create_ship) {CreateShip.new}
  let(:ships_list) {ShipsList.new(create_ship)}
  let(:validated_ui) {ValidatedUi.new(ui, grid)}
  let(:ships_owner) {HumanPlayer.new("Gabriella", grid, validated_ui, ui, ships_list)}
  let(:attacker) {HumanPlayer.new("Nic", grid, validated_ui, ui, ships_list)}

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

  it "asks to correctly type either human player or computer as opponent" do
    input = StringIO.new("Computer")
    ui = Ui.new(input, output, grid_display)

    rival = ui.repeat_rival_type

    expect(output.string).to include("Sorry, I didn't understand:")
    expect(rival).to eq("computer")
  end

  it "confirms all ships were placed" do
    ui.confirm_ships_were_placed

    expect(output.string).to include("All ships were placed.")
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

  it "asks to choose ship number and prints list of ships" do
    input = StringIO.new("1")
    ui = Ui.new(input, output, grid_display)

    ship_number = ui.selected_ship("Gabriella", ships_list)

    expect(ship_number).to eq(1)
    expect(output.string).to include("Gabriella, choose a number for ship to place:\n")
    expect(output.string).to include("1- submarine\n2- destroyer\n3- cruiser\n4- aircraft-carrier\n")
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

  it "asks for new position if previous given is already occupied and returns hash" do
    input = StringIO.new("1,a,v\n")
    ui = Ui.new(input, output, grid_display)

    position = ui.ask_for_empty_position

    expect(output.string).to include("Position already occupied:")
    expect(position).to eq({:x => 1, :y=> "A", :orientation => :vertical})
  end

end
