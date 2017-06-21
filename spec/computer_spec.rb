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

    it "returns random ship on grid from list of 6 ships" do
    ship = computer.ship_placement

    possible_ships = {"submarine" => 2,
                      "destroyer" => 2,
                      "cruiser" => 1,
                      "aircraft-carrier" => 1
                      }
    possible_positions = {:x => [1, 2, 3, 4, 5, 6, 7, 8, 9, 10],
                         :y => ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J"]
                       }
    ship_coordinate_x = ship.occupied_cells[0][0]
    ship_coordinate_y = ship.occupied_cells[0][1]

    expect(possible_ships.keys.include?(ship.name)).to eq(true)
    expect(possible_positions[:x].include?(ship_coordinate_x)).to eq(true)
    expect(possible_positions[:y].include?(ship_coordinate_y)).to eq(true)
  end

end
