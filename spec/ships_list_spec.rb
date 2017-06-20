require 'spec_helper'
require_relative '../lib/ships_list'
require_relative '../lib/ship'

RSpec.describe ShipsList do

  let(:create_ship) {CreateShip.new}
  let(:ships_list) {ShipsList.new(create_ship)}

  def count_ships(list)
    list.values.inject {|sum, value| sum + value}
  end

  it "has a list of 6 ships to place on grid" do
    ships_count = count_ships(ships_list.ships)

    expect(ships_count).to eq(6)
  end

  it "deletes a selected ship from the list and creates ship instance" do
    ship = ships_list.prepare_ship("submarine")

    ships_count = count_ships(ships_list.ships)

    expect(ships_count).to eq(5)
    expect(ships_list.ships["submarine"]).to eq(1)
    expect(ship).to have_attributes(:name => "submarine", :length => 1)
  end

  it "converts the player's input as number into name of ship" do
    players_input = 2

    ship_name = ships_list.convert_number_to_name(players_input)

    expect(ship_name).to eq("destroyer")
  end

  describe "checks player's entered number corresponds to a ship" do
    it "returns :invalid_ship_number for invalid number" do
      output = ships_list.validate("5")

      expect(output).to eq(:invalid_ship_number)
    end

    it "returns :invalid_ship_number for invalid input type" do
      output = ships_list.validate("hello")

      expect(output).to eq(:invalid_ship_number)
    end

    it "returns :valid_ship_number for valid input" do
      output = ships_list.validate("2")

      expect(output).to eq(:valid_ship_number)
    end
  end

end
