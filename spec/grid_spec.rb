require_relative "../lib/grid"

RSpec.describe Grid do

  let(:grid) {Grid.new}
  let(:game) {Game.new(grid)}

  describe "registers positions of all ships placed" do
    it "registers submarine with its position in the list of ships placed" do
      submarine = Ship.new("submarine", 1)

      grid.mark_ship_positions(5, "A", submarine, "vertical")

      expect(grid.ships_placed).to eq({submarine => [[5, "A"]]})
    end

    it "registers destroyer with its position in the list of ships placed" do
      destroyer = Ship.new("destroyer", 2)

      grid.mark_ship_positions(5, "B", destroyer, "vertical")

      expect(grid.ships_placed).to eq({destroyer => [[5, "B"], [5, "C"]]})
    end

    it "registers cruiser with its position in the list of ships placed" do
      cruiser = Ship.new("cruiser", 3)

      grid.mark_ship_positions(5, "B", cruiser, "horizontal")

      expect(grid.ships_placed).to eq({cruiser => [[5, "B"], [6, "B"],[7, "B"]]})
    end

    it "registers aircraft_carrier with its position in the list of ships placed" do
      aircraft_carrier = Ship.new("aircraft-carrier", 4)

      grid.mark_ship_positions(5, "B", aircraft_carrier, "vertical")

      expect(grid.ships_placed).to eq({aircraft_carrier => [[5, "B"], [5, "C"],[5, "D"],[5, "E"]]})
    end
  end

  describe "checks if a cell is already occupied by a ship" do
    it "returns true if a cell is occupied" do
      aircraft_carrier = Ship.new("aircraft-carrier", 4)

      grid.mark_ship_positions(2, "B", aircraft_carrier, "horizontal")

      expect(grid.ship?([4, "B"])).to eq(true)
    end

    it "returns false if a cell is not occupied" do
      aircraft_carrier = Ship.new("aircraft-carrier", 4)

      grid.mark_ship_positions(2, "B", aircraft_carrier, "vertical")

      expect(grid.ship?([9, "B"])).to eq(false)
    end
  end

  it "returns the ship that occupies a position" do
    aircraft_carrier = Ship.new("aircraft-carrier", 4)

    grid.mark_ship_positions(2, "B", aircraft_carrier, "horizontal")
    ship = grid.ship_on([4, "B"])

    expect(ship.name).to eq("aircraft-carrier")
  end

end
