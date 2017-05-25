require_relative "../lib/grid"

RSpec.describe Grid do

  let(:grid) {Grid.new}

  describe "validates its cells" do
    it "has 100 cells" do
      number_of_cells = grid.cells.size

      expect(number_of_cells).to eq(100)
    end

    it "has 6J as valid cell" do
      cell = grid.cell?("6J")

      expect(cell).to eq(true)
    end

    it "does not have 23H as valid cell" do
      cell = grid.cell?("23H")

      expect(cell).to eq(false)
    end
  end

  it "places the ship" do

  end

end
