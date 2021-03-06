require 'spec_helper'
require_relative '../lib/grid_display'
require_relative '../lib/grid'
require_relative '../lib/ship'

RSpec.describe GridDisplay do

  let(:grid) {Grid.new(10)}
  let(:grid_display) {GridDisplay.new(grid.size)}

  it "creates visual representation of grid" do
    expect(grid_display.prepare_grid).to eq("       1   2   3   4   5   6   7   8   9   10   \n   A   .   .   .   .   .   .   .   .   .   .   \n   B   .   .   .   .   .   .   .   .   .   .   \n   C   .   .   .   .   .   .   .   .   .   .   \n   D   .   .   .   .   .   .   .   .   .   .   \n   E   .   .   .   .   .   .   .   .   .   .   \n   F   .   .   .   .   .   .   .   .   .   .   \n   G   .   .   .   .   .   .   .   .   .   .   \n   H   .   .   .   .   .   .   .   .   .   .   \n   I   .   .   .   .   .   .   .   .   .   .   \n   J   .   .   .   .   .   .   .   .   .   .   \n")
  end

  describe "updates the grid by adding H for 'hit'" do
    it "adds H for position [1, a]" do
       grid_display.hit([1, "A"])

       grid_position = grid_display.representation[1][1]

       expect(grid_position).to eq("H")
    end

    it "adds H for position [1, b]" do
       grid_display.hit([1, "B"])

       grid_position = grid_display.representation[2][1]

       expect(grid_position).to eq("H")
    end

    it "adds H for position [3, c]" do
       grid_display.hit([3, "C"])

       grid_position = grid_display.representation[3][3]

       expect(grid_position).to eq("H")
    end

    it "adds H for position [4, c]" do
       grid_display.hit([4, "C"])

       grid_position = grid_display.representation[3][4]

       expect(grid_position).to eq("H")
    end
  end

  describe "updates the grid by adding W for 'water'" do
    it "adds W for position [1, a]" do
        grid_display.water([1, "A"])

        grid_position = grid_display.representation[1][1]

        expect(grid_position).to eq("W")
    end

    it "adds W for position [1, b]" do
      grid_display.water([1, "B"])

      grid_position = grid_display.representation[2][1]

      expect(grid_position).to eq("W")
    end

    it "adds W for position [3, c]" do
      grid_display.water([3, "C"])

      grid_position = grid_display.representation[3][3]

      expect(grid_position).to eq("W")
    end

    it "adds W for position [4, c]" do
      grid_display.water([4, "C"])

      grid_position = grid_display.representation[3][4]

      expect(grid_position).to eq("W")
    end
  end

  describe "updates the grid by adding S for 'sunk'" do
     it "adds S for position [1, a]" do
       grid_display.sunk([[1, "A"]])

       grid_position = grid_display.representation[1][1]

       expect(grid_position).to eq("S")
     end

     it "adds S for positions [1, a] and [1, b]" do
       grid_display.sunk([[1, "A"], [1, "B"]])

       grid_position1 = grid_display.representation[1][1]
       grid_position2 = grid_display.representation[2][1]

       expect(grid_position1).to eq("S")
       expect(grid_position2).to eq("S")
     end

     it "adds S for positions [1, a], [1, b] and [1, c]" do
       grid_display.sunk([[1, "A"], [1, "B"], [1, "C"]])

       grid_position1 = grid_display.representation[1][1]
       grid_position2 = grid_display.representation[2][1]
       grid_position3 = grid_display.representation[3][1]

       expect(grid_position1).to eq("S")
       expect(grid_position2).to eq("S")
       expect(grid_position3).to eq("S")
     end

     it "adds S for positions [1, a], [1, b], [1, c] and [1, d]" do
       grid_display.sunk([[1, "A"], [1, "B"], [1, "C"], [1, "D"]])

       grid_position1 = grid_display.representation[1][1]
       grid_position2 = grid_display.representation[2][1]
       grid_position3 = grid_display.representation[3][1]
       grid_position4 = grid_display.representation[4][1]

       expect(grid_position1).to eq("S")
       expect(grid_position2).to eq("S")
       expect(grid_position3).to eq("S")
       expect(grid_position4).to eq("S")
     end
    end

  describe "updates grid with :w or :h according to result after attack" do
    it "adds H on grid if attack result is :hit" do
       result = :hit
       attacked_cell = [1, "A"]
       grid_display.update_grid(result, attacked_cell, grid)

       grid_position = grid_display.representation[1][1]

       expect(grid_position).to eq("H")
     end

     it "adds W on grid if attack result is :water" do
       result = :water
       attacked_cell = [1, "A"]
       grid_display.update_grid(result, attacked_cell, grid)

       grid_position = grid_display.representation[1][1]

       expect(grid_position).to eq("W")
     end

     it "adds S on grid if attack result is :sunk" do
       ship = Ship.new("destroyer", 2)
       ship.register_position(5, "B", :vertical)
       grid.add_ship(ship)
       ship.register_cells_hit([5, "B"])
       ship.register_cells_hit([5, "C"])
       grid.register_sunk_ship_positions(ship)

       result = :sunk
       attacked_cell = [5, "C"]
       grid_display.update_grid(result, attacked_cell, grid)
       grid_position = grid_display.representation[2][5]
       grid_position2 = grid_display.representation[3][5]

       expect(grid_position).to eq("S")
       expect(grid_position2).to eq("S")
     end
  end

end
