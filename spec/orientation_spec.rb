require_relative '../lib/orientation'

RSpec.describe Orientation do

  let(:orientation) {Orientation.new}

  it "returns ship's horizontal positions" do
    horizontal_cells = orientation.horizontal_cells(1, "A", 2)

    expect(horizontal_cells).to eq([[1, "A"], [2, "A"]])
  end

  it "returns ship's vertical positions" do
    vertical_cells = orientation.vertical_cells(1, "A", 3)

    expect(vertical_cells).to eq([[1, "A"], [1, "B"], [1, "C"]])
  end

end
