require_relative "../lib/ship"

RSpec.describe Ship do

  let(:grid) {Grid.new}

  it "knows its position in grid" do
    cruiser = Ship.new("cruiser",3)

    grid.mark_ship_positions(5,"B",cruiser)

    expect(cruiser.occupied_cells(grid)).to eq([[5,"B"],[6,"B"],[7,"B"]])
  end

  it "returns true if it is hit" do
    cruiser = Ship.new("cruiser",3)
    attacked_cell = [7,"B"]

    grid.mark_ship_positions(5,"B",cruiser)

    expect(cruiser.hit?(attacked_cell,grid)).to eq(true)
  end

  it "returns false if it is not hit" do
    cruiser = Ship.new("cruiser",3)
    attacked_cell = [7,"B"]

    grid.mark_ship_positions(5,"A",cruiser)

    expect(cruiser.hit?(attacked_cell,grid)).to eq(false)
  end

  it "keeps track of its cells hit" do
    aircraft_carrier = Ship.new("aircraft-carrier",4)
    grid.mark_ship_positions(2,"B",aircraft_carrier)
    attacked_cell = [3,"B"]

    aircraft_carrier.register_cells_hit(attacked_cell,grid)

    expect(aircraft_carrier.cells_hit).to eq([[3,"B"]])
  end

  it "returns true if it is sunk" do
    destroyer = Ship.new("destroyer",2)
    grid.mark_ship_positions(5,"B",destroyer)
    attacked_cell1 = [5,"B"]
    attacked_cell2 = [6,"B"]

    destroyer.register_cells_hit(attacked_cell1,grid)
    destroyer.register_cells_hit(attacked_cell2,grid)

    expect(destroyer.sunk?).to eq(true)
  end

  it "returns false if it is not sunk" do
    destroyer = Ship.new("destroyer",2)
    grid.mark_ship_positions(5,"B",destroyer)
    attacked_cell1 = [5,"B"]
    attacked_cell2 = [7,"B"]

    destroyer.register_cells_hit(attacked_cell1,grid)
    destroyer.register_cells_hit(attacked_cell2,grid)

    expect(destroyer.sunk?).to eq(false)
  end

  it "cannot register multiple times same cell hit" do
    destroyer = Ship.new("destroyer",2)
    grid.mark_ship_positions(5,"B",destroyer)
    attacked_cell1 = [5,"B"]
    attacked_cell2 = [7,"B"]

    destroyer.register_cells_hit(attacked_cell1,grid)
    destroyer.register_cells_hit(attacked_cell1,grid)
    destroyer.register_cells_hit(attacked_cell2,grid)

    expect(destroyer.sunk?).to eq(false)
  end

end
