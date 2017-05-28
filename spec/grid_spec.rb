require_relative "../lib/grid"

RSpec.describe Grid do

  let(:grid) {Grid.new}

  describe "registers positions of all ships placed" do
    it "registers submarine with its position in the list of ships placed" do
      submarine = Ship.new("submarine",1)

      grid.place_ship(5,5,submarine)

      expect(grid.ships_placed).to eq({submarine => [[5,5]]})
    end

    it "registers destroyer with its position in the list of ships placed" do
      destroyer = Ship.new("destroyer",2)

      grid.place_ship(5,5,destroyer)

      expect(grid.ships_placed).to eq({destroyer => [[5,5], [6,5]]})
    end

    it "registers cruiser with its position in the list of ships placed" do
      cruiser = Ship.new("cruiser",3)

      grid.place_ship(5,5,cruiser)

      expect(grid.ships_placed).to eq({cruiser => [[5,5], [6,5],[7,5]]})
    end

    it "registers aircraft_carrier with its position in the list of ships placed" do
      aircraft_carrier = Ship.new("aircraft-carrier",4)

      grid.place_ship(5,5,aircraft_carrier)

      expect(grid.ships_placed).to eq({aircraft_carrier => [[5,5], [6,5],[7,5],[8,5]]})
    end
  end

  describe "checks if a cell is already occupied by a ship" do
    it "returns true if a cell is occupied" do
      aircraft_carrier = Ship.new("aircraft-carrier",4)

      grid.place_ship(2,2,aircraft_carrier)

      expect(grid.ship?([4,2])).to eq(true)
    end

    it "returns false if a cell is not occupied" do
      aircraft_carrier = Ship.new("aircraft-carrier",4)

      grid.place_ship(2,2,aircraft_carrier)

      expect(grid.ship?([9,2])).to eq(false)
    end
  end
  
end
