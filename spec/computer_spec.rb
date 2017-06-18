require 'spec_helper'
require_relative '../lib/computer'
require_relative '../lib/grid'
require_relative '../lib/grid_display'
require_relative '../lib/ships_list'
require_relative '../lib/create_ship'

RSpec.describe Computer do

  let(:grid) {Grid.new(10)}
  let(:create_ship) {CreateShip.new}
  let(:ships_list) {ShipsList.new(create_ship)}
  let(:grid_display) {GridDisplay.new(grid.size)}
  let(:computer) {Computer.new(grid, ships_list)}

  it "places ship on grid from list of 6 ships randomly" do
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
