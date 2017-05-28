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

end
