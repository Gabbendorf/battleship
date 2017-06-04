require_relative "../lib/ship"

RSpec.describe Ship do

  let(:grid) {Grid.new}

  xit "knows its position in grid" do
    cruiser = Ship.new("cruiser", 3)

    grid.mark_ship_positions(5, "B", cruiser, "vertical")

    expect(cruiser.occupied_cells(grid)).to eq([[5, "B"], [5, "C"], [5, "D"]])
  end

  it "keeps track of its cells hit" do
    aircraft_carrier = Ship.new("aircraft-carrier", 4)
    grid.mark_ship_positions(2, "B", aircraft_carrier, "vertical")
    attacked_cell1 = [2, "D"]
    attacked_cell2 = [2, "E"]

    aircraft_carrier.register_cells_hit(attacked_cell1)
    aircraft_carrier.register_cells_hit(attacked_cell2)

    expect(aircraft_carrier.cells_hit).to eq([[2, "D"], [2, "E"]])
  end

  it "returns true if it is sunk" do
    destroyer = Ship.new("destroyer", 2)
    grid.mark_ship_positions(5, "B", destroyer, "horizontal")
    attacked_cell1 = [5, "B"]
    attacked_cell2 = [6, "B"]

    destroyer.register_cells_hit(attacked_cell1)
    destroyer.register_cells_hit(attacked_cell2)

    expect(destroyer.sunk?).to eq(true)
  end

  it "returns false if it is not sunk" do
    destroyer = Ship.new("destroyer", 2)
    grid.mark_ship_positions(5, "B", destroyer, "horizontal")
    attacked_cell1 = [5, "B"]

    destroyer.register_cells_hit(attacked_cell1)

    expect(destroyer.sunk?).to eq(false)
  end

  it "cannot register multiple times same cell hit" do
    destroyer = Ship.new("destroyer", 2)
    grid.mark_ship_positions(5, "B", destroyer, "vertical")
    attacked_cell1 = [5, "B"]
    attacked_cell2 = [5, "C"]

    destroyer.register_cells_hit(attacked_cell1)
    destroyer.register_cells_hit(attacked_cell1)
    destroyer.register_cells_hit(attacked_cell2)

    expect(destroyer.cells_hit.size).to eq(2)
  end

end
