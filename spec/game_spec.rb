require 'spec_helper.rb'
require_relative '../lib/game'
# require_relative '../lib/ships_list'
require_relative '../lib/ui'

RSpec.describe Game do

  let(:grid_display) {GridDisplay.new}
  let(:input) {StringIO.new}
  let(:output) {StringIO.new}
  let(:ui) {Ui.new(input, output, grid_display)}
  let(:grid) {Grid.new}
  let(:player) {Player.new(grid)}
  let(:ships_list) {ShipsList.new}
  let(:game) {Game.new(grid_display, ui, grid, player, ships_list, validations)}

  xit "starts a new game" do
    ui = double("ui")
    expect(ui).to receive(:welcome)
    expect(ui).to receive(:ask_name_player1).and_return("Gabriella")

    game.start
  end

  xit "prompts player to choose position for ship from list and to place all of them" do
    ui = double("ui")
    player = double("player")

    expect(ui).to receive(:invite_to_select_ship_number).with("Gabriella") { 1 }
    expect(ui).to receive(:display_grid).with(grid_display)
    # expect(ui).to receive(:coordinates_and_orientation).and_return({:x => 1, :y => "b", :orientation => :vertical})
    expect(player).to receive(:place_ship).with(1, "a", ship, :vertical)

    expect(game.ships_placement("Gabriella")).to
  end

end
