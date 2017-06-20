require 'spec_helper'
require_relative "../lib/ship"

RSpec.describe Ship do

  it "generates its position on grid" do
    cruiser = Ship.new("cruiser", 3)

    cruiser.register_position(5, "B", :vertical)

    expect(cruiser.occupied_cells).to eq([[5, "B"], [5, "C"], [5, "D"]])
  end

  it "keeps track of its cells hit" do
    aircraft_carrier = Ship.new("aircraft-carrier", 4)
    attacked_cell1 = [2, "D"]
    attacked_cell2 = [2, "E"]

    aircraft_carrier.register_cells_hit(attacked_cell1)
    aircraft_carrier.register_cells_hit(attacked_cell2)

    expect(aircraft_carrier.cells_hit).to eq([[2, "D"], [2, "E"]])
  end

  it "returns true if it is sunk" do
    destroyer = Ship.new("destroyer", 2)
    attacked_cell1 = [5, "B"]
    attacked_cell2 = [6, "B"]

    destroyer.register_cells_hit(attacked_cell1)
    destroyer.register_cells_hit(attacked_cell2)

    expect(destroyer.sunk?).to eq(true)
  end

  it "returns false if it is not sunk" do
    destroyer = Ship.new("destroyer", 2)
    attacked_cell1 = [5, "B"]

    destroyer.register_cells_hit(attacked_cell1)

    expect(destroyer.sunk?).to eq(false)
  end

  it "cannot register multiple times same cell hit" do
    destroyer = Ship.new("destroyer", 2)
    attacked_cell1 = [5, "B"]
    attacked_cell2 = [5, "C"]

    destroyer.register_cells_hit(attacked_cell1)
    destroyer.register_cells_hit(attacked_cell1)
    destroyer.register_cells_hit(attacked_cell2)

    expect(destroyer.cells_hit.size).to eq(2)
  end

  describe "looks if ship occupies a position" do
    it "returns true if ship occupies a position" do
      aircraft_carrier = Ship.new("aircraft-carrier", 4)
      aircraft_carrier.register_position(2, "B", :horizontal)

      existing_ship = aircraft_carrier.does_occupy?([4, "B"])

      expect(existing_ship).to eq(true)
    end

    it "returns false if no ship occupies a position" do
      aircraft_carrier = Ship.new("aircraft-carrier", 4)
      aircraft_carrier.register_position(2, "B", :horizontal)

      existing_ship = aircraft_carrier.does_occupy?([3, "C"])

      expect(existing_ship).to eq(false)
    end
  end

end
