require_relative '../lib/validated_ui'
require_relative '../lib/ships_list'
require_relative '../lib/ui'
require_relative '../lib/grid'
require_relative '../lib/grid_display'
require_relative '../lib/ship'

RSpec.describe ValidatedUi do

  let(:grid) {Grid.new(10)}
  let(:grid_display) {GridDisplay.new(grid.size)}
  let(:output) {StringIO.new}
  let(:ui) {Ui.new(input, output, grid_display)}
  let(:ships_list) {ShipsList.new}
  let(:grid) {Grid.new(10)}
  let(:destroyer) {Ship.new("destroyer", 2)}

  def set_up_validated_ui(input)
    input = StringIO.new(input)
    ui = Ui.new(input, output, grid_display)
    ValidatedUi.new(ui, ships_list, grid)
  end

  it "validates input for ship number and returns ship name" do
    validated_ui = set_up_validated_ui("8\n2\n")

    valid_number = validated_ui.selected_ship

    expect(valid_number).to eq("destroyer")
  end

  it "returns a valid input for ship placement" do
    validated_ui = set_up_validated_ui("1,z,h\n1,j,v\n1,a,h")

    valid_placement = validated_ui.valid_position(destroyer)

    expect(valid_placement).to eq({:x => 1, :y => "A", :orientation => :horizontal})
  end

  it "returns a valid input for cell to attack" do
    validated_ui = set_up_validated_ui("1,z\n100,j\n1,a")

    valid_attack = validated_ui.valid_cell_to_attack("Gabriella")

    expect(valid_attack).to eq([1, "A"])
  end

end
