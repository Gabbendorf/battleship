require_relative '../lib/player'

RSpec.describe Player do

  let(:grid) {Grid.new}
  let(:player) {Player.new(grid)}

  it "places ship on grid" do
    player.place_ship(2, "A", "submarine", "horizontal")
    player.place_ship(3, "B", "destroyer", "vertical")

    submarine = grid.ships_placed.keys[0]
    destroyer = grid.ships_placed.keys[1]
    destroyer_position = grid.ships_placed.values[1]

    expect(submarine).to have_attributes(:name => "submarine", :length => 1)
    expect(destroyer).to have_attributes(:name => "destroyer", :length => 2)
    expect(destroyer_position).to eq([[3, "B"], [3, "C"]])
  end

  describe "selects cell to attack from grid" do
    it "returns :water if cell attacked is empty" do
      destroyer = Ship.new("destroyer", 2)
      grid.mark_ship_positions(5, "B", destroyer, "vertical")
      cell_to_attack = [8, "B"]

      result = player.attack(cell_to_attack)

      expect(result).to eq(:water)
    end

    it "returns :hit if cell attacked is occupied" do
      destroyer = Ship.new("destroyer", 2)
      grid.mark_ship_positions(5, "B", destroyer, "horizontal")
      cell_to_attack = [5, "B"]

      result = player.attack(cell_to_attack)

      expect(result).to eq(:hit)
    end
  end

end
