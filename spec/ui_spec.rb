require_relative '../lib/ui'
require_relative '../lib/ship'

RSpec.describe Ui do

  let(:create_grid) {CreateGrid.new}
  let(:input) {StringIO.new}
  let(:output) {StringIO.new}
  let(:ui) {Ui.new(input, output, create_grid)}
  let(:ship) {Ship.new}
  let(:ships_list) {ShipsList.new}

  it "welcomes the players" do
    ui.welcome

    expect(output.string).to include("Welcome to Battleship!")
  end

  it "asks for name of player 1" do
    input = StringIO.new("Gabriella")
    ui = Ui.new(input,output,create_grid)

    player_name = ui.ask_name_player1

    expect(output.string).to include("Player 1: enter your name")
    expect(player_name).to eq("Gabriella")
  end

  it "displays the grid" do
    ui.display_grid

    expect(output.string).to include("  1   2   3   4   5   6   7   8   9   10   \n")

  end

  it "invites player 1 to choose number for ship to place" do
    ui.invite_to_select_ship_number("Gabriella")

    expect(output.string).to include("Gabriella, choose a number for type of ship to place:")
  end

  it "prints the list of ships to be placed" do
    ui.print_list_of_ships(ships_list)

    expect(output.string).to include("1- submarine\n2- destroyer\n3- cruiser\n4- aircraft-carrier\n")
  end

  it "registers selected ship" do
    input = StringIO.new("1")
    ui = Ui.new(input,output,create_grid)

    ship = ui.selected_ship

    expect(ship).to eq("submarine")
  end

  it "asks for coordinates where to place ship and orientation" do
    input = StringIO.new("1,a,v")
    ui = Ui.new(input,output,create_grid)

    coordinates_and_orientation = ui.coordinates_and_orientation

    expect(output.string).to include("Choose 2 coordinates X,Y and an orientation h for 'horizontal' or v for 'vertical' (ex. 2,b,h)")
    expect(coordinates_and_orientation).to eq({:x => 1, :y=> "A", :orientation => "v"})
  end

  it "asks for name of player 2" do
    input = StringIO.new("Gabriella")
    ui = Ui.new(input,output,create_grid)

    player_name = ui.ask_name_player2

    expect(output.string).to include("Player 2: enter your name")
    expect(player_name).to eq("Gabriella")
  end

  it "asks for coordinates x,y to attack" do
    input = StringIO.new("1,a")
    ui = Ui.new(input,output,create_grid)

    cell_to_attack = ui.cell_to_attack("Gabriella")

    expect(output.string).to include("Gabriella, where do you want to attack (ex. 3,b)?")
    expect(cell_to_attack).to eq([1, "A"])
  end

  it "declares a winner" do
    ui.declare_winner

    expect(output.string).to include("Congratulations: YOU WON!")
  end

end
