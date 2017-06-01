require_relative '../lib/ships_list'

RSpec.describe ShipsList do

  let(:ships_list) {ShipsList.new}

  def count_ships(list)
    list.values.inject {|sum, value| sum + value}
  end

  it "has a list of 6 ships to place on grid" do
    ships_count = count_ships(ships_list.ships)

    expect(ships_count).to eq(6)
  end

  it "deletes a selected ship from the list of ships to place on grid" do
    updated_list = ships_list.delete_selected_ship(1)

    ships_count = count_ships(updated_list)

    expect(ships_count).to eq(5)
    expect(ships_list.ships[1]).to eq(1)
  end

  it "deletes ship from list if there are 0 of that type" do
    ships_list.delete_selected_ship(3)

    expect(ships_list.ships).to eq({1 => 2, 2 => 2, 4 =>1})
  end


end
