require 'spec_helper.rb'
require_relative '../lib/validations'
require_relative '../lib/ship'

RSpec.describe Validations do

  let(:validations) {Validations.new}

  describe "checks player's entered number corresponds to a ship" do
    it "returns :error for invalid number" do
      output = validations.validate_ship_number("5")

      expect(output).to eq(:invalid_ship_number)
    end

    it "returns :error for invalid input type" do
      output = validations.validate_ship_number("hello")

      expect(output).to eq(:invalid_ship_number)
    end

    it "returns nil for valid input" do
      output = validations.validate_ship_number("2")

      expect(output).to eq(:valid_ship_number)
    end
  end

  describe "checks player's inputs for ship to place are all valid" do
    it "returns :error if 1st coordinate is not number" do
      output = validations.validate_position_for_ship("a,b,h")

      expect(output).to eq(:invalid_ship_position)
    end

    it "returns :error if 1st coordinate is not valid number" do
      output = validations.validate_position_for_ship("100,b,h")

      expect(output).to eq(:invalid_ship_position)
    end

    it "returns :error if 2nd coordinate is a number" do
      output = validations.validate_position_for_ship("1,2,h")

      expect(output).to eq(:invalid_ship_position)
    end

    it "returns :error if 2nd coordinate is an invalid letter" do
      output = validations.validate_position_for_ship("1,x,h")

      expect(output).to eq(:invalid_ship_position)
    end

    it "returns :error if 3rd coordinate (orientation) is not valid (vertical case)" do
      output = validations.validate_position_for_ship("1,b,c")

      expect(output).to eq(:invalid_ship_position)
    end

    it "returns :error if 3rd coordinate (orientation) is not valid (horizontal case)" do
      output = validations.validate_position_for_ship("1,b,d")

      expect(output).to eq(:invalid_ship_position)
    end

    it "returns :error if all inputs are invalid" do
      output = validations.validate_position_for_ship("100,x,c")

      expect(output).to eq(:invalid_ship_position)
    end

    it "returns nil if all inputs are valid" do
      output = validations.validate_position_for_ship("1,a,h")

      expect(output).to eq(:valid_ship_position)
    end
  end

  describe "checks if ship stays inside grid according to player's input for its position" do
    it "returns :error if ship doesn't stay inside grid vertically" do
      destroyer = Ship.new("destroyer", 2)
      grid_position = "1,a,v"

      output = validations.check_ship_is_inside_grid(destroyer, grid_position)

      expect(output).to eq(:invalid_placement)
    end

    it "returns :error if ship doesn't stay inside grid vertically" do
      destroyer = Ship.new("destroyer", 2)
      grid_position = "6,a,v"

      output = validations.check_ship_is_inside_grid(destroyer, grid_position)

      expect(output).to eq(:invalid_placement)
    end

    it "returns nil if ship stays inside grid vertically" do
      destroyer = Ship.new("destroyer", 2)
      grid_position = "2,b,v"

      output = validations.check_ship_is_inside_grid(destroyer, grid_position)

      expect(output).to eq(:valid_placement)
    end

    it "returns :error if ship doesn't stay inside grid horizontally" do
      destroyer = Ship.new("destroyer", 2)
      grid_position = "10,a,h"

      output = validations.check_ship_is_inside_grid(destroyer, grid_position)

      expect(output).to eq(:invalid_placement)
    end

    it "returns :error if ship doesn't stay inside grid horizontally" do
      destroyer = Ship.new("destroyer", 2)
      grid_position = "10,j,h"

      output = validations.check_ship_is_inside_grid(destroyer, grid_position)

      expect(output).to eq(:invalid_placement)
    end

    it "returns nil if ship stays inside grid horizontally" do
      destroyer = Ship.new("destroyer", 2)
      grid_position = "9,j,h"

      output = validations.check_ship_is_inside_grid(destroyer, grid_position)

      expect(output).to eq(:valid_placement)
    end
  end

  describe "checks that position to attack is valid" do
    it "returns :error for invalid number" do
      output = validations.validate_position_to_attack("11,a")

      expect(output).to eq(:invalid_attack)
    end

    it "returns :error for invalid letter" do
      output = validations.validate_position_to_attack("8,z")

      expect(output).to eq(:invalid_attack)
    end

    it "returns nil for valid coordinates" do
      output = validations.validate_position_to_attack("8,a")

      expect(output).to eq(:valid_attack)
    end
  end

end
