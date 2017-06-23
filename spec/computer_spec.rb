require 'spec_helper'
require_relative '../lib/computer'
require_relative '../lib/grid'
require_relative '../lib/grid_display'
require_relative '../lib/ships_list'
require_relative '../lib/create_ship'
require_relative '../lib/ship'

RSpec.describe Computer do

  let(:grid) {Grid.new(10)}
  let(:create_ship) {CreateShip.new}
  let(:ships_list) {ShipsList.new(create_ship)}
  let(:grid_display) {GridDisplay.new(grid.size)}
  let(:ship) {Ship.new("submarine", 1)}
  let(:computer) {Computer.new(grid, ships_list)}

  it "returns random ship with random position from list of 6 ships" do
    possible_ships = {"submarine" => 2,
                      "destroyer" => 2,
                      "cruiser" => 1,
                      "aircraft-carrier" => 1
                      }

    ship = computer.ship_placement
    grid.add_ship(ship)
    occupied_grid_cells = grid.ships_placed[0].occupied_cells

    expect(possible_ships.keys.include?(ship.name)).to eq(true)
    expect(occupied_grid_cells).to eq(ship.occupied_cells)
  end

end
