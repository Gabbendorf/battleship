require_relative '../lib/orientation'

RSpec.describe Orientation do

  let(:orientation) {Orientation.new}

  it "returns ship's horizontal positions" do
    horizontal_cells = orientation.horizontal_cells(1, "A", 1)

    expect(horizontal_cells).to eq([[1, "A"]])
  end

end
