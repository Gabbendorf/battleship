require_relative '../lib/create_ship'

RSpec.describe CreateShip do

  let(:create_ship) {CreateShip.new}

  it "creates istance of submarine" do
    submarine = create_ship.ship_from_name("submarine")

    expect(submarine).to have_attributes(:name => "submarine", :length => 1)
  end

  it "creates istance of destroyer" do
    submarine = create_ship.ship_from_name("destroyer")

    expect(submarine).to have_attributes(:name => "destroyer", :length => 2)
  end

  it "creates istance of cruiser" do
    submarine = create_ship.ship_from_name("cruiser")

    expect(submarine).to have_attributes(:name => "cruiser", :length => 3)
  end

  it "creates istance of aircraft-carrier" do
    submarine = create_ship.ship_from_name("aircraft-carrier")

    expect(submarine).to have_attributes(:name => "aircraft-carrier", :length => 4)
  end

end
