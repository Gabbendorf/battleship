require 'spec_helper'
require_relative '../lib/computer'

RSpec.describe Computer do

  let(:grid) {Grid.new}
  let(:ships_list) {ShipsList.new}
  let(:computer) {Computer.new(grid, ships_list)}

  it "chooses ship from ships list randomly until list is empty" do
    ship_name = computer.select_randomly_ship

    expect(ships_list.ships.keys.include?(ship_name)).to eq(true)
  end

  it "gives position for ship placement randomly" do
    position = computer.select_random_position

    x = position[0]
    y = position[1]
    orientation = position[2]
    valid_numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    valid_letters = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J"]

    expect(position.length).to eq(3)
    expect(valid_numbers).to include(x)
    expect(valid_letters).to include(y)
    expect([:vertical, :horizontal]).to include(orientation)
  end

  # how can I test this further?
  it "places random ship on grid from list of 6 ships" do
    destroyer = Ship.new("destroyer", 2)
    possible_ship_types = ["submarine", "destroyer", "cruiser", "aircraft-carrier"]

    computer.place_ship(1, "A", destroyer, :vertical)

    expect(grid.ships_placed.size).to eq(6)
  end

end
