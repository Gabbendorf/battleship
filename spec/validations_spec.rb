require_relative '../lib/validations'

RSpec.describe Validations do

  let(:output) {StringIO.new}
  let(:input) {StringIO.new}
  let(:grid_display) {GridDisplay.new}
  let(:ui) {Ui.new(input, output, grid_display)}
  let(:validations) {Validations.new(ui)}

  it "it raises error for wrong input for ship number" do
    input = StringIO.new("2\n")
    ui = Ui.new(input, output, grid_display)
    validations = Validations.new(ui)

    output = validations.validate_ship_number("5")

    expect(output).to eq(:error)
  end

end
