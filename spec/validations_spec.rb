require_relative '../lib/validations'

RSpec.describe Validations do

  let(:validations) {Validations.new}

  it "raises error for wrong input for ship number" do
    output = validations.validate_ship_number("5")

    expect(output).to eq(:error)
  end

  it "raises error for wrong input for ship number" do
    output = validations.validate_ship_number("hello")

    expect(output).to eq(:error)
  end

end
