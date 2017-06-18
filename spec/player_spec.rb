require 'spec_helper'
require_relative '../lib/player'
require_relative '../lib/grid_display'
require_relative '../lib/grid'
require_relative '../lib/validated_ui'
require_relative '../lib/ships_list'
require_relative '../lib/create_ship'
require_relative '../lib/ui'

RSpec.describe Player do

  let(:grid) {Grid.new(10)}
  let(:grid_display) {GridDisplay.new(grid.size)}
  let(:input) {StringIO.new}
  let(:output) {StringIO.new}
  let(:ui) {Ui.new(input, output, grid_display)}
  let(:create_ship) {CreateShip.new}
  let(:ships_list) {ShipsList.new(create_ship)}
  let(:validated_ui) {ValidatedUi.new(ui, ships_list, grid)}
  let(:player) {Player.new("Gabriella", grid, validated_ui)}

  it "returns a correctly placed ship with its position on grid" do
    input = StringIO.new("1\n1,a,h\n")
    ui = Ui.new(input, output, grid_display)
    validated_ui = ValidatedUi.new(ui, ships_list, grid)
    player = Player.new("Gabriella", grid, validated_ui)

    ship = player.placement_move(player.name, ships_list)

    expect(ship).to have_attributes(:name => "submarine", :length => 1, :occupied_cells => [[1, "A"]])
  end

  describe "selects cell to attack from grid" do
    it "returns :water if cell attacked is empty" do
      destroyer = Ship.new("destroyer", 2)
      grid.mark_ship_positions(5, "B", destroyer, :vertical)
      cell_to_attack = [8, "B"]

      result = player.attack(cell_to_attack)

      expect(result).to eq(:water)
    end

    it "returns :hit if cell attacked is occupied" do
      destroyer = Ship.new("destroyer", 2)

      grid.mark_ship_positions(5, "B", destroyer, :horizontal)
      cell_to_attack = [5, "B"]

      cell_hit = destroyer.register_cells_hit(cell_to_attack).to_a
      sunk_ships = grid.add_sunk_ship(destroyer)
      result = player.attack(cell_to_attack)

      expect(result).to eq(:hit)
      expect(cell_hit).to eq([[5, "B"]])
      expect(sunk_ships).to eq(nil)
    end
  end

end
