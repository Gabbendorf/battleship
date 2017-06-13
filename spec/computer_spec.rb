require 'spec_helper'
require_relative '../lib/computer'

RSpec.describe Computer do

  let(:grid) {Grid.new}
  let(:ships_list) {ShipsList.new}
  let(:validations) {Validations.new}
  let(:computer) {Computer.new(grid, ships_list, validations)}

  # how can I test this further?
  it "places random ship on grid from list of 6 ships" do
    destroyer = Ship.new("destroyer", 2)

    computer.place_ship(1, "A", destroyer, :vertical)

    expect(grid.ships_placed.size).to eq(6)
    puts grid.ships_placed
  end

end
