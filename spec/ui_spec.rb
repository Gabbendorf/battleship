require_relative '../lib/ui'
require_relative '../lib/ship'

RSpec.describe Ui do

  let(:input) {StringIO.new}
  let(:output) {StringIO.new}
  let(:ui) {Ui.new(input,output)}
  let(:ship) {Ship.new}
  let(:ships_list) {ShipsList.new}

  it "welcomes the players" do
    ui.welcome

    expect(output.string).to include("Welcome to Battleship!")
  end

  it "asks for name of player 1" do
    input = StringIO.new("Gabriella")
    ui = Ui.new(input,output)

    player_name = ui.ask_name_player1

    expect(output.string).to include("Player 1: enter your name")
    expect(player_name).to eq("Gabriella")
  end

  it "displays the grid" do
    ui.display_grid

    expect(output.string).to include("  1   2   3   4   5   6   7   8   9   10   \nA .   .   .   .   .   .   .   .   .   .  \nB .   .   .   .   .   .   .   .   .   .  \nC .   .   .   .   .   .   .   .   .   .  \nD .   .   .   .   .   .   .   .   .   .  \nE .   .   .   .   .   .   .   .   .   .  \nF .   .   .   .   .   .   .   .   .   .  \nG .   .   .   .   .   .   .   .   .   .  \nH .   .   .   .   .   .   .   .   .   .  \nI .   .   .   .   .   .   .   .   .   .  \nJ .   .   .   .   .   .   .   .   .   .  \n")

  end

  it "invites player 1 to choose number for ship to place" do
    ui.invite_to_select_ship_number("Gabriella")

    expect(output.string).to include("Gabriella, choose a number for type of ship to place:")
  end

  it "prints the list of ships to be placed" do
    ui.print_list_of_ships(ships_list)

    expect(output.string).to include("1- submarine\n2- destroyer\n3- cruiser\n4- aircraft-carrier\n")
  end

  it "registers number for ship" do
    input = StringIO.new("submarine")
    ui = Ui.new(input,output)

    ui.selected_ship_number

    expect(input.string).to include("submarine")
  end

  it "asks for coordinates where to place ship and orientation" do
    input = StringIO.new("1,a,vertical")
    ui = Ui.new(input,output)

    coordinates_and_orientation = ui.coordinates_and_orientation("submarine")

    expect(output.string).to include("Choose 2 coordinates X,Y and an orientation 'horizontal' or 'vertical' (ex. 2,b,vertical)")
    expect(coordinates_and_orientation).to eq([1, "A", "vertical"])
  end

end
