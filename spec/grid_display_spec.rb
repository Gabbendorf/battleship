require 'spec_helper.rb'
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

   describe "updates the grid by adding W for 'water'" do
      it "adds W for position [1, a]" do
        grid_display.water([1, "A"])

        grid_position = grid_display.grid[1][1]

        expect(grid_position).to eq("W")
      end

      it "adds W for position [1, b]" do
        grid_display.water([1, "B"])

        grid_position = grid_display.grid[2][1]

        expect(grid_position).to eq("W")
      end

      it "adds W for position [3, c]" do
        grid_display.water([3, "C"])

        grid_position = grid_display.grid[3][3]

        expect(grid_position).to eq("W")
      end

      it "adds W for position [4, c]" do
        grid_display.water([4, "C"])

        grid_position = grid_display.grid[3][4]

        expect(grid_position).to eq("W")
      end
    end

    describe "updates the grid by adding S for 'sunk'" do
       it "adds S for position [1, a]" do
         grid_display.sunk([[1, "A"]])

         ship_position = grid_display.grid[1][1]

         expect(ship_position).to eq("S")
       end

       it "adds S for positions [1, a] and [1, b]" do
         grid_display.sunk([[1, "A"], [1, "B"]])

         ship_position1 = grid_display.grid[1][1]
         ship_position2 = grid_display.grid[2][1]

         expect(ship_position1).to eq("S")
         expect(ship_position2).to eq("S")
       end

       it "adds S for positions [1, a], [1, b] and [1, c]" do
         grid_display.sunk([[1, "A"], [1, "B"], [1, "C"]])

         ship_position1 = grid_display.grid[1][1]
         ship_position2 = grid_display.grid[2][1]
         ship_position3 = grid_display.grid[3][1]

         expect(ship_position1).to eq("S")
         expect(ship_position2).to eq("S")
         expect(ship_position3).to eq("S")
       end

       it "adds S for positions [1, a], [1, b], [1, c] and [1, d]" do
         grid_display.sunk([[1, "A"], [1, "B"], [1, "C"], [1, "D"]])

         ship_position1 = grid_display.grid[1][1]
         ship_position2 = grid_display.grid[2][1]
         ship_position3 = grid_display.grid[3][1]
         ship_position4 = grid_display.grid[4][1]

         expect(ship_position1).to eq("S")
         expect(ship_position2).to eq("S")
         expect(ship_position3).to eq("S")
         expect(ship_position4).to eq("S")
       end
     end

end
