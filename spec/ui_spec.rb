require_relative '../lib/ui'

RSpec.describe Ui do

  let(:input) {StringIO.new}
  let(:output) {StringIO.new}
  let(:ui) {Ui.new(input,output)}

  it "welcomes the players" do
    ui.welcome

    expect(output.string).to include("Welcome to Battleship. Are you ready to play?")
  end

  it "asks player1 to place the ships" do
    ui.invite_to_place_ships

    expect(output.string).to include("Player 1: place all the ships. Make sure Player 2 does not see.")
  end



end
