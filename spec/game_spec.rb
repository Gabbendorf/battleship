require 'spec_helper.rb'
require_relative '../lib/game'

RSpec.describe Game do

  let(:grid_display) {GridDisplay.new}
  let(:output) {StringIO.new}
  let(:grid) {Grid.new}
  let(:player) {Player.new(grid)}
  let(:ships_list) {ShipsList.new}
  let(:validations) {Validations.new}
  let(:computer) {Computer.new(grid, ships_list, validations)}

  it "starts a new game" do
    input = StringIO.new("Gabriella\n10\n1\n1,a,k\n1,a,h\n1\n100,b,h\n1,b,h\n1\n1,z,h\n1,c,h\n1\n1,d,h\n1\n1,e,h\n1\n1,f,h\nNicolo\n1,k\n1,a\n100,b\n1,b\n9,c\n1,c\n2,c\n1,d\n2,d\n1,e\n2,e\n3,e\n1,f\n2,f\n3,f\n4,f\n")

    ui = Ui.new(input, output, grid_display)
    game = Game.new(grid_display, ui, grid, player, ships_list, validations, computer)

    game.start
  end

end
