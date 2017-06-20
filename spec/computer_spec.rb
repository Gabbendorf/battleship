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

  def placed_ships_count(ship_name)
    ships = []
    grid.ships_placed.each do |ship|
      if ship.name == ship_name
        ships.push(ship)
      end
    end
    ships.count
  end

  it "places ship on grid from list of 6 ships randomly" do
    computer.ship_placement

    possible_ships = {"submarine" => 2,
                      "destroyer" => 2,
                      "cruiser" => 1,
                      "aircraft-carrier" => 1
                      }
    submarine = possible_ships.keys[0]
    destroyer = possible_ships.keys[1]
    cruiser = possible_ships.keys[2]
    aircraft_carrier = possible_ships.keys[3]

    expect(grid.ships_placed.size).to eq(6)
    expect(placed_ships_count(submarine)).to eq(2)
    expect(placed_ships_count(destroyer)).to eq(2)
    expect(placed_ships_count(cruiser)).not_to eq(2)
    expect(placed_ships_count(cruiser)).to eq(1)
    expect(placed_ships_count(aircraft_carrier)).to eq(1)
  end

end
