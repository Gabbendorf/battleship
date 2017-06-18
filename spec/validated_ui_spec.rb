require_relative '../lib/validated_ui'
require_relative '../lib/ships_list'
require_relative '../lib/ui'
require_relative '../lib/grid'
require_relative '../lib/grid_display'

RSpec.describe ValidatedUi do

  let(:grid) {Grid.new(10)}
  let(:grid_display) {GridDisplay.new(grid.size)}
  let(:output) {StringIO.new}
  let(:ui) {Ui.new(input, output, grid_display)}
  let(:ships_list) {ShipsList.new}

  it "returns a valid input for ship number" do
    input = StringIO.new("8\n2\n")
    ui = Ui.new(input, output, grid_display)
    validated_ui = ValidatedUi.new(ui, ships_list)

    valid_number = validated_ui.selected_ship

    expect(valid_number).to eq(2)
  end

end
