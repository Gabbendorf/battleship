require_relative "../lib/ships"

RSpec.describe Ships do

  let(:ships) {Ships.new}

  it "has a list of 6 ships" do
    list = ships.list_of_ships

    expect(list.length).to eq(6)
  end

end
