require 'spec_helper'
require_relative '../lib/human_player'
require_relative '../lib/grid_display'
require_relative '../lib/grid'
require_relative '../lib/validated_ui'
require_relative '../lib/ships_list'
require_relative '../lib/create_ship'
require_relative '../lib/ui'
require_relative '../lib/ship'

RSpec.describe HumanPlayer do

  let(:grid) {Grid.new(10)}
  let(:grid_display) {GridDisplay.new(grid.size)}
  let(:output) {StringIO.new}
  let(:ui) {Ui.new(input, output, grid_display)}
  let(:create_ship) {CreateShip.new}
  let(:ships_list) {ShipsList.new(create_ship)}

  it "returns a ship with valid position to be placed on grid" do
    input = StringIO.new("1\n1,a,z\n1,a,h\n")
    ui = Ui.new(input, output, grid_display)
    validated_ui = ValidatedUi.new(ui, grid)
    player = HumanPlayer.new("Gabriella", grid, validated_ui, ui, ships_list)

    ship = player.ship_placement

    expect(ship).to have_attributes(:name => "submarine", :length => 1, :occupied_cells => [[1, "A"]])
  end

  it "returns player's valid cell given to attack" do
    input = StringIO.new("8,z\n7,b\n")
    ui = Ui.new(input, output, grid_display)
    validated_ui = ValidatedUi.new(ui, grid)
    player = HumanPlayer.new("Gabriella", grid, validated_ui, ui, ships_list)

    result = player.ship_attack("Gabriella")

    expect(result).to eq([7, "B"])
  end

end
