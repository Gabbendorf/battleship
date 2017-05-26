require_relative '../lib/ui'

RSpec.describe Ui do

  let(:input) {StringIO.new}
  let(:output) {StringIO.new}
  let(:ui) {Ui.new(input,output)}

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
    ui.ships

    expect(output.string).to include ("- Submarine\n- Destroyer\n- Cruiser\n- Aircraft-carrier.")
  end

end
