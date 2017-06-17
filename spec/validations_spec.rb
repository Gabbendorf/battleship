require 'spec_helper'
require_relative '../lib/validations'

RSpec.describe Validations do

  let(:grid_display) {GridDisplay.new}
  let(:validations) {Validations.new(grid_display)}

  describe "checks that position to attack is valid" do
    it "returns :invalid_attack for invalid number" do
      output = validations.validate_position_to_attack([11, "a"])

      expect(output).to eq(:invalid_attack)
    end

    it "returns :invalid_attack for invalid letter" do
      output = validations.validate_position_to_attack([8, "z"])

      expect(output).to eq(:invalid_attack)
    end

    it "returns :valid_attack for valid coordinates" do
      output = validations.validate_position_to_attack([8, "a"])

      expect(output).to eq(:valid_attack)
    end
  end

end
