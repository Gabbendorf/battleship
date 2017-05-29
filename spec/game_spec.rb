require_relative '../lib/game'

RSpec.describe Game do

  let(:grid) {Grid.new}
  let(:game) {Game.new(grid)}

  it "places ship on grid" do
    ship_name = "submarine"
    ship_name2 = "destroyer"

    game.place_ship(2,2,ship_name)
    game.place_ship(3,3,ship_name2)
    submarine = grid.ships_placed.keys[0]
    destroyer = grid.ships_placed.keys[1]
    destroyer_position = grid.ships_placed.values[1]

    expect(submarine).to have_attributes(:name => "submarine",:length => 1)
    expect(destroyer).to have_attributes(:name => "destroyer",:length => 2)
    expect(destroyer_position).to eq([[3,3],[4,3]])
  end

end
