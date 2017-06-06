require_relative '../lib/grid_display'

RSpec.describe GridDisplay do

  let(:grid_display) {GridDisplay.new}

  describe "updates the grid by adding H for 'hit'" do
     it "adds H for position [1, a]" do
       grid_display.hit([1, "A"])

       grid_position = grid_display.grid[1][1]

       expect(grid_position).to eq("H")
     end

     it "adds H for position [1, b]" do
       grid_display.hit([1, "B"])

       grid_position = grid_display.grid[2][1]

       expect(grid_position).to eq("H")
     end

     it "adds H for position [3, c]" do
       grid_display.hit([3, "C"])

       grid_position = grid_display.grid[3][3]

       expect(grid_position).to eq("H")
     end

     it "adds H for position [4, c]" do
       grid_display.hit([4, "C"])

       grid_position = grid_display.grid[3][4]

       expect(grid_position).to eq("H")
     end
   end

end
