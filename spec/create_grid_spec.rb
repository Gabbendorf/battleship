require_relative '../lib/create_grid'

RSpec.describe CreateGrid do

  let(:create_grid) {CreateGrid.new}

   it "adds H for position [1, a]" do
     create_grid.hit([1, "A"])

     grid_position = create_grid.grid[1][1]

     expect(grid_position).to eq("H")
   end

   it "adds H for position [1, b]" do
     create_grid.hit([1, "B"])

     grid_position = create_grid.grid[2][1]

     expect(grid_position).to eq("H")
   end

   it "adds H for position [3, c]" do
     create_grid.hit([3, "C"])

     grid_position = create_grid.grid[3][3]

     expect(grid_position).to eq("H")
   end

end
