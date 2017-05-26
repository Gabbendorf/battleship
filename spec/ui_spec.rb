require_relative '../lib/ui'
require_relative '../lib/ships'

RSpec.describe Ui do

  let(:input) {StringIO.new}
  let(:output) {StringIO.new}
  let(:ui) {Ui.new(input,output)}
  let(:ships) {Ships.new}

  it "welcomes the players" do
    ui.welcome

    expect(output.string).to include("Welcome to Battleship. Are you ready to play?")
  end

  it "displays the grid" do
    ui.display_grid

    expect(output.string).to include("  1  2  3  4  5  6  7  8  9  10  \nA .  .  .  .  .  .  .  .  .  .  \nB .  .  .  .  .  .  .  .  .  .  \nC .  .  .  .  .  .  .  .  .  .  \nD .  .  .  .  .  .  .  .  .  .  \nE .  .  .  .  .  .  .  .  .  .  \nF .  .  .  .  .  .  .  .  .  .  \nG .  .  .  .  .  .  .  .  .  .  \nH .  .  .  .  .  .  .  .  .  .  \nI .  .  .  .  .  .  .  .  .  .  \nJ")
  end

  it "invites player 1 to choose ship to place" do
    ui.invite_to_choose_ship

    expect(output.string).to include("Player 1: choose a ship to place.")
  end

  it "displays list of ships" do
    ships.list_of_ships
    ui.ships
    expect(output.string).to include ("- submarine\n- submarine\n- destroyer\n- destroyer\n- cruiser\n- aircraft-carrier\n")
  end

  it "gets ship to place from player 1" do
    input = StringIO.new("submarine\n")
    ui = Ui.new(input, output)

    ui.get_ship

    expect(output.string).to include()
  end

end
