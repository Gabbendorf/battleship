require_relative "../lib/ship"

RSpec.describe Ship do

  let(:grid) {Grid.new}

  xit "returns true if it is hit" do
    submarine = Ship.new("submarine",1)
    attacked_cell = [1,1]

    grid.place_ship(1,1,submarine)

    expect(submarine.hit?(attacked_cell,grid)).to eq(true)
  end

  it "knows its position in grid" do
    cruiser = Ship.new("cruiser",3)

    grid.place_ship(5,5,cruiser)

    expect(cruiser.position(grid)).to eq([[5,5],[6,5],[7,5]])
  end

end
