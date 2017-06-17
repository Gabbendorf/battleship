require 'spec_helper'
require_relative '../lib/computer'

RSpec.describe Computer do

  let(:grid) {Grid.new(10)}
  let(:ships_list) {ShipsList.new}
  let(:grid_display) {GridDisplay.new}
  let(:computer) {Computer.new(grid, ships_list)}

  xit "places ship on grid from list of 6 ships randomly" do
    computer.place_ship

    possible_ships_name = ["submarine", "destroyer", "cruiser", "aircraft-carrier"]
    ship1_name = grid.ships_placed.keys[0].name
    ship2_name = grid.ships_placed.keys[1].name
    ship3_name = grid.ships_placed.keys[2].name
    ship4_name = grid.ships_placed.keys[3].name
    ship5_name = grid.ships_placed.keys[4].name
    ship6_name = grid.ships_placed.keys[5].name
    all_ship_names = [ship1_name, ship2_name, ship3_name, ship4_name, ship5_name, ship6_name]
    is_valid_name = all_ship_names.map {|name| possible_ships_name.include?(name)}

    expect(is_valid_name).to eq([true] * 6)
    expect(grid.ships_placed.size).to eq(6)
  end

end
