require 'spec_helper'
require_relative '../lib/player'

RSpec.describe Player do

  let(:grid) {Grid.new}
  let(:ships_owner) {Player.new("Gabriella", grid)}
  let(:attacker) {Player.new("Jarkyn", grid)}

  it "places ship on grid" do
    submarine = Ship.new("submarine", 1)
    destroyer = Ship.new("destroyer", 2)
    ships_owner.place_ship(2, "A", submarine, :horizontal)
    ships_owner.place_ship(3, "B", destroyer, :vertical)

    submarine = grid.ships_placed.keys[0]
    destroyer = grid.ships_placed.keys[1]

    expect(submarine).to have_attributes(:name => "submarine", :length => 1)
    expect(destroyer).to have_attributes(:name => "destroyer", :length => 2)
  end

  describe "selects cell to attack from grid" do
    it "returns :water if cell attacked is empty" do
      destroyer = Ship.new("destroyer", 2)
      grid.mark_ship_positions(5, "B", destroyer, :vertical)
      cell_to_attack = [8, "B"]

      result = attacker.attack(cell_to_attack)

      expect(result).to eq(:water)
    end

    it "returns :hit if cell attacked is occupied" do
      destroyer = Ship.new("destroyer", 2)

      grid.mark_ship_positions(5, "B", destroyer, :horizontal)
      cell_to_attack = [5, "B"]

      cell_hit = destroyer.register_cells_hit(cell_to_attack).to_a
      sunk_ships = grid.add_sunk_ship(destroyer)
      result = attacker.attack(cell_to_attack)

      expect(result).to eq(:hit)
      expect(cell_hit).to eq([[5, "B"]])
      expect(sunk_ships).to eq(nil)
    end
  end

end
