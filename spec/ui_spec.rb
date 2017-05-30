require_relative '../lib/ui'
require_relative '../lib/ship'

RSpec.describe Ui do

  let(:input) {StringIO.new}
  let(:output) {StringIO.new}
  let(:ui) {Ui.new(input,output)}
  let(:ship) {Ship.new}

  it "welcomes the players" do
    ui.welcome

    expect(output.string).to include("Welcome to Battleship!")
  end

  it "asks for name of player 1" do
    ui.ask_name_player1

    expect(output.string).to include("Player 1: enter your name")
  end

  it "displays the grid" do
    ui.display_grid

    expect(output.string).to include("  1  2  3  4  5  6  7  8  9  10  \nA .  .  .  .  .  .  .  .  .  .  \nB .  .  .  .  .  .  .  .  .  .  \nC .  .  .  .  .  .  .  .  .  .  \nD .  .  .  .  .  .  .  .  .  .  \nE .  .  .  .  .  .  .  .  .  .  \nF .  .  .  .  .  .  .  .  .  .  \nG .  .  .  .  .  .  .  .  .  .  \nH .  .  .  .  .  .  .  .  .  .  \nI .  .  .  .  .  .  .  .  .  .  \nJ")
  end

  it "invites player 1 to choose ship to place" do
    ui.invite_to_select_ship

    expect(output.string).to include("Player 1, choose a ship to place:")
  end

  it "prints the list of ships to be placed" do
    ui.print_list_of_ships

    expect(output.string).to include("- submarine\n- destroyer\n- cruise\n- aircraft-carrier\n")
  end

  it "registers selected ship" do
    input = StringIO.new("submarine")
    ui = Ui.new(input,output)

    ui.selected_ship

    expect(input.string).to include("submarine")
  end

  it "asks for coordinates of cell where to place ship" do
    ui.ask_for_coordinates("submarine")

    expect(output.string).to include("Where do you want to place the submarine (number,number)?")
  end

  it "registers chosen coordinates where to place ship" do
    input = StringIO.new("1,1")
    ui = Ui.new(input,output)

    ui.coordinates_for_ship

    expect(input.string).to include("1,1")
  end

end
