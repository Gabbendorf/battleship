require 'spec_helper.rb'
require_relative '../lib/game'
require_relative '../lib/grid'
require_relative '../lib/grid_display'
require_relative '../lib/ui'
require_relative '../lib/create_ship'
require_relative '../lib/ships_list'
require_relative '../lib/validated_ui'
require_relative '../lib/computer'
require_relative '../lib/player'


RSpec.describe Game do

  let(:grid) {Grid.new(10)}
  let(:grid_display) {GridDisplay.new(grid.size)}
  let(:output) {StringIO.new}
  let(:ui) {Ui.new(input, output, grid_display)}
  let(:create_ship) {CreateShip.new}
  let(:ships_list) {ShipsList.new(create_ship)}
  let(:validated_ui) {ValidatedUi.new(ui, ships_list, grid)}
  let(:computer) {Computer.new(grid, ships_list)}
  # let(:player1) {Player.new("Gabriella", grid, validated_ui, ui)}
  # let(:player2) {Player.new("Nicolo", grid, validated_ui, ui)}

  it "starts a new game" do
    PLAYER1 = "Gabriella\n"
    WRONG_INPUT = "10\n"
    FIRST_SHIP = "1\n"
    WRONG_POSITION = "1,a,k\n"
    POSITION1 = "1,a,h\n"
    SECOND_SHIP = "1\n"
    POSITION2 = "1,b,h\n"
    THIRD_SHIP = "1\n"
    POSITION3 = "1,c,h\n"
    FOURTH_SHIP = "1\n"
    POSITION4 = "1,d,h\n"
    FIFTH_SHIP = "1\n"
    POSITION5 = "1,e,h\n"
    SIXTH_SHIP = "1\n"
    POSITION6 = "1,f,h\n"
    PLAYER2 = "Nicolo\n"
    WRONG_ATTACK = "100,z\n"
    SINK_SHIP1 = "1,a\n"
    SINK_SHIP2 = "1,b\n"
    HIT_SHIP3 = "1,c\n"
    SINK_SHIP3 = "2,c\n"
    HIT_SHIP4 = "1,d\n"
    SINK_SHIP4 = "2,d\n"
    HIT_SHIP5 = "1,e\n"
    HIT2_SHIP5 = "2,e\n"
    SINK_SHIP5 = "3,e\n"
    HIT_SHIP6 = "1,f\n"
    HIT2_SHIP6 = "2,f\n"
    HIT3_SHIP6 = "3,f\n"
    SINK_SHIP6 = "4,f\n"

    input = StringIO.new(PLAYER1+WRONG_INPUT+FIRST_SHIP+WRONG_POSITION+POSITION1+SECOND_SHIP+POSITION2+THIRD_SHIP+POSITION3+FOURTH_SHIP+POSITION4+FIFTH_SHIP+POSITION5+SIXTH_SHIP+POSITION6+PLAYER2+
                         WRONG_ATTACK+SINK_SHIP1+SINK_SHIP2+HIT_SHIP3+SINK_SHIP3+HIT_SHIP4+SINK_SHIP4+HIT_SHIP5+HIT2_SHIP5+SINK_SHIP5+HIT_SHIP6+HIT2_SHIP6+HIT3_SHIP6+SINK_SHIP6)
    ui = Ui.new(input, output, grid_display)
    validated_ui = ValidatedUi.new(ui, ships_list, grid)
    game = Game.new(grid_display, ui, grid, ships_list, computer, validated_ui)
    game.start

    expect(grid.end_game?).to eq(true)
  end

end
