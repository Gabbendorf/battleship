require 'spec_helper'
require_relative '../lib/grid'
require_relative '../lib/ship'

RSpec.describe Grid do

  let(:grid) {Grid.new(10)}
  let(:ship) {Ship.new("destroyer", 2)}

  it "has a size" do
    expect(grid.size).to eq(10)
  end

  describe "knows where ship can be placed" do
    it "returns :invalid_ship_position if 1st coordinate is invalid number" do
      ui_output = {:x => "a", :y => "B", :orientation => :horizontal}
      result = grid.validate_placement(ui_output, ship.length)

      expect(result).to eq(:invalid_ship_position)
    end

    it "returns :invalid_ship_position if 2nd coordinate is invalid letter" do
      ui_output = {:x => "1", :y => "Z", :orientation => :horizontal}
      result = grid.validate_placement(ui_output, ship.length)

      expect(result).to eq(:invalid_ship_position)
    end

    it "returns :invalid_ship_position if 3rd coordinate (orientation) is not valid" do
      ui_output = {:x => "1", :y => "B", :orientation => "c"}
      result = grid.validate_placement(ui_output, ship.length)

      expect(result).to eq(:invalid_ship_position)
    end

    it "returns :valid_position if all inputs are valid" do
      ui_output = {:x => "1".to_i, :y => "A", :orientation => :horizontal}
      output = grid.validate_placement(ui_output, ship.length)

      expect(output).to eq(:valid_position)
    end
  end

  describe "checks if ship stays inside grid according to player's input for position" do
    it "returns :invalid_placement if ship doesn't stay inside grid vertically" do
      ui_output = {:x => "1".to_i, :y => "J", :orientation => :vertical}

      result = grid.validate_placement(ui_output, ship.length)

      expect(result).to eq(:invalid_placement)
    end

    it "returns :valid_position if ship stays inside grid vertically" do
      ui_output = {:x => "9".to_i, :y => "I", :orientation => :vertical}

      result = grid.validate_placement(ui_output, ship.length)

      expect(result).to eq(:valid_position)
    end

    it "returns :invalid_placement if ship doesn't stay inside grid horizontally" do
      ui_output = {:x => "10".to_i, :y => "A", :orientation => :horizontal}

      result = grid.validate_placement(ui_output, ship.length)

      expect(result).to eq(:invalid_placement)
    end

    it "returns :valid_position if ship stays inside grid horizontally" do
      ui_output = {:x => "9".to_i, :y => "J", :orientation => :horizontal}

      result = grid.validate_placement(ui_output, ship.length)

      expect(result).to eq(:valid_position)
    end
  end

  describe "checks that position to attack is valid" do
    it "returns false for invalid number" do
      result = grid.position_in_grid?(11, "A")

      expect(result).to eq(false)
    end

    it "returns false for invalid letter" do
      result = grid.position_in_grid?(8, "Z")

      expect(result).to eq(false)
    end

    it "returns true for valid coordinates" do
      result = grid.position_in_grid?(8, "A")

      expect(result).to eq(true)
    end
  end

  it "registers ship with its position in the list of ships placed" do
    submarine = Ship.new("submarine", 1)
    submarine.register_position(1, "A", :horizontal)
    destroyer = Ship.new("destroyer", 2)
    destroyer.register_position(1, "B", :horizontal)

    grid.add_ship(submarine)
    grid.add_ship(destroyer)

    expect(grid.ships_placed).to eq([submarine, destroyer])
    expect(grid.ships_placed.size).to eq(2)
  end

  def set_up_sunk_submarine
    submarine = Ship.new("submarine", 1)
    submarine.register_position(1, "A", :horizontal)
    grid.add_ship(submarine)
    submarine.register_cells_hit([1, "G"])
    grid.ships_placed[0]
  end

  it "adds a sunk ship in a list" do
    sunk_submarine = set_up_sunk_submarine

    grid.register_sunk_ship_positions(sunk_submarine)

    expect(grid.ships_sunk_positions).to eq([[1, "A"]])
  end

  it "returns true if all ships are sunk" do
    sunk_submarine = set_up_sunk_submarine
    grid.register_sunk_ship_positions(sunk_submarine)

    verdict = grid.end_game?

    expect(verdict).to eq(true)
  end

  it "returns false if not all ships are sunk" do
    sunk_submarine = set_up_sunk_submarine
    grid.register_sunk_ship_positions(sunk_submarine)
    submarine2 = Ship.new("submarine", 1)
    submarine2.register_position(2, "G", :vertical)
    grid.add_ship(submarine2)

    verdict = grid.end_game?

    expect(verdict).to eq(false)
  end

  describe "returns result :hit, :sunk or :water after each attack" do
    it "returns :hit for hit occupied cell" do
      ship.register_position(1, "A", :horizontal)
      grid.add_ship(ship)

      attacked_cell = [1, "A"]

      expect(grid.show_result(attacked_cell)).to eq(:hit)
    end

    it "returns :water for no hit cell" do
      ship.register_position(1, "A", :horizontal)
      grid.add_ship(ship)

      attacked_cell = [8, "A"]

      expect(grid.show_result(attacked_cell)).to eq(:water)
    end

    it "returns :sunk for all cells of ship hit" do
      ship.register_position(1, "A", :horizontal)
      grid.add_ship(ship)

      attacked_cell = [1, "A"]
      attacked_cell2 = [2, "A"]
      ship.register_cells_hit(attacked_cell)
      ship.register_cells_hit(attacked_cell2)

      expect(grid.show_result(attacked_cell)).to eq(:sunk)
    end
  end

end
