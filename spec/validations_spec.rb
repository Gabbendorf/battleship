require 'spec_helper'
require_relative '../lib/validations'

RSpec.describe Validations do

  let(:validations) {Validations.new}

  describe "checks player's entered number corresponds to a ship" do
    it "returns :error for invalid number" do
      output = validations.validate_ship_number("5")

      expect(output).to eq(:error)
    end

    it "returns :error for invalid input type" do
      output = validations.validate_ship_number("hello")

      expect(output).to eq(:error)
    end
  end

  describe "checks player's inputs for ship to place are all valid" do
    it "returns :error if 1st coordinate is not number" do
      output = validations.validate_ship_to_place_position("a, b, h")

      expect(output).to eq(:error)
    end

    it "returns :error if 1st coordinate is not valid number" do
      output = validations.validate_ship_to_place_position("100, b, h")

      expect(output).to eq(:error)
    end

    it "returns :error if 2nd coordinate is a number" do
      output = validations.validate_ship_to_place_position("1, 2, h")

      expect(output).to eq(:error)
    end

    it "returns :error if 2nd coordinate is an invalid letter" do
      output = validations.validate_ship_to_place_position("1, x, h")

      expect(output).to eq(:error)
    end

    it "returns :error if 3rd coordinate (orientation) is not v (vertical case)" do
      output = validations.validate_ship_to_place_position("1, b, c")

      expect(output).to eq(:error)
    end

    it "returns :error if 3rd coordinate (orientation) is not h (horizontal case)" do
      output = validations.validate_ship_to_place_position("1, b, d")

      expect(output).to eq(:error)
    end
  end

end
