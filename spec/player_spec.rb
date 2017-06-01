require_relative '../lib/player'

RSpec.describe Player do

  let(:grid) {Grid.new}
  let(:player) {Player.new(grid)}

  it "places ship on grid" do
    ship_name = "submarine"
    ship_name2 = "destroyer"

    player.place_ship(2, 2, ship_name)
    player.place_ship(3, 3, ship_name2)
    submarine = grid.ships_placed.keys[0]
    destroyer = grid.ships_placed.keys[1]
    destroyer_position = grid.ships_placed.values[1]

    expect(submarine).to have_attributes(:name => "submarine", :length => 1)
    expect(destroyer).to have_attributes(:name => "destroyer", :length => 2)
    expect(destroyer_position).to eq([[3, 3], [4, 3]])
  end

  describe "selects cell to attack from grid" do
    it "returns :water if cell attacked is empty" do
      ship = Ship.new("destroyer", 2)
      grid.place_ship(5, 5, ship)
      cell_to_attack = [8, 5]

      result = player.attack(cell_to_attack)

      expect(result).to eq(:water)
    end

    it "returns :hit if cell attacked is occupied" do
      ship = Ship.new("destroyer", 2)
      grid.place_ship(5, 5, ship)
      cell_to_attack = [5, 5]

      result = player.attack(cell_to_attack)

      expect(result).to eq(:hit)
    end
  end

end
