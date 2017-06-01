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
    ships_list.delete_selected_ship("submarine")

    ships_count = count_ships(ships_list.ships)

    expect(ships_count).to eq(5)
    expect(ships_list.ships["submarine"]).to eq(1)
  end

  it "deletes ship from list if there are 0 of that type" do
    ships_list.delete_selected_ship("cruiser")

    expect(ships_list.ships).to eq({"submarine" => 2, "destroyer" => 2, "aircraft-carrier" =>1})
  end

  it "converts the player's input as number into name of ship" do
    players_input = 2

    ship_name = ships_list.convert_number_to_name(players_input)

    expect(ship_name).to eq("destroyer")
  end

end
