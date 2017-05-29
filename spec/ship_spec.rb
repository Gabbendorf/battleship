require_relative "../lib/ship"

RSpec.describe Ship do

  let(:grid) {Grid.new}

  it "knows its position in grid" do
    cruiser = Ship.new("cruiser",3)

    grid.place_ship(5,5,cruiser)

    expect(cruiser.occupied_cells(grid)).to eq([[5,5],[6,5],[7,5]])
  end

  it "returns true if it is hit" do
    cruiser = Ship.new("cruiser",3)
    attacked_cell = [7,5]

    grid.place_ship(5,5,cruiser)

    expect(cruiser.hit?(attacked_cell,grid)).to eq(true)
  end

  it "returns false if it is not hit" do
    cruiser = Ship.new("cruiser",3)
    attacked_cell = [7,3]

    grid.place_ship(5,5,cruiser)

    expect(cruiser.hit?(attacked_cell,grid)).to eq(false)
  end

  it "keeps track of its cells hit" do
    aircraft_carrier = Ship.new("aircraft-carrier",4)
    grid.place_ship(2,2,aircraft_carrier)
    attacked_cell = [3,2]

    aircraft_carrier.register_cells_hit(attacked_cell,grid)

    expect(aircraft_carrier.cells_hit).to eq([[3,2]])
  end

  xit "returns true if it is sunk" do
    cruiser = Ship.new("cruiser",3)
    attacked_cell1 = [5,5]
    attacked_cell2 = [6,5]
    attacked_cell3 = [7,5]

    grid.place_ship(5,5,cruiser)
    ship.hit?(attacked_cell1,grid)
    ship.hit?(attacked_cell2,grid)
    ship.hit?(attacked_cell3,grid)

    expect(ship.sunk?).to eq(true)
  end

end
