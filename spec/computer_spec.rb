require 'spec_helper'
require_relative '../lib/computer'

RSpec.describe Computer do

  let(:grid) {Grid.new}
  let(:ships_list) {ShipsList.new}
  let(:computer) {Computer.new(grid, ships_list)}

  it "chooses ship from ships list randomly until list is empty" do
    ship_name = computer.select_ship

    expect(ships_list.ships.keys.include?(ship_name)).to eq(true)
  end

  xit "places submarine on grid" do
    computer.place_ship("submarine")
  end

end
