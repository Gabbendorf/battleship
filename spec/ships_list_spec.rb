require_relative '../lib/ships_list'

RSpec.describe ShipsList do

  let(:ships_list) {ShipsList.new}

  it "has a list of 6 ships" do
    ships_count = ships_list.ships.values.inject {|sum, value| sum + value}

    expect(ships_count).to eq(6)
  end



end
