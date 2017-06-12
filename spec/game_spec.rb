require 'spec_helper.rb'
require_relative '../lib/game'

RSpec.describe Game do

  let(:grid_display) {GridDisplay.new}
  let(:output) {StringIO.new}
  let(:input) {StringIO.new}
  let(:grid) {Grid.new}
  let(:player) {Player.new(grid)}
  let(:ships_list) {ShipsList.new}
  let(:validations) {Validations.new}

  it "starts a new game" do
    input.puts "Gabriella\n"
    # places 1st submarine
    input.puts "10\n" #=> invalid list number
    input.puts "1\n"
    input.puts "1,a,k\n" #=> invalid orientation
    input.puts "1,a,h\n"
    # places 2nd submarine
    input.puts "1\n"
    input.puts "100,b,h\n" #=> invalid number for x
    input.puts "1,b,h\n"
    # places 1st destroyer
    input.puts "1\n"
    input.puts "1,z,h\n" #=> invalid letter for y
    input.puts "1,c,h\n"
    # places 2nd destroyer
    input.puts "1\n"
    input.puts "1,d,h\n"
    # places cruiser
    input.puts "1\n"
    input.puts "1,e,h\n"
    # places aircraft-carrier
    input.puts "1\n"
    input.puts "1,f,h\n"

    input.puts "Nicolò\n"
    # attacks 1st submarine, 1 cell long
    input.puts "1,k\n" #=> invalid attack (wrong letter)
    input.puts "1,a\n"
    # attacks 2nd submarine, 1 cell long
    input.puts "100,b\n" #=> invalid attack (wrong number)
    input.puts "1,b\n"
    # attacks 1st destroyer, 2 cells long
    input.puts "1,c\n"
    input.puts "2,c\n"
    # attacks 2nd destroyer, 2 cells long
    input.puts "1,d\n"
    input.puts "2,d\n"
    # attacks cruiser, 3 cells long
    input.puts "1,e\n"
    input.puts "2,e\n"
    input.puts "3,e\n"
    # attacks aircraft-carrier, 4 cells long
    input.puts "1,f\n"
    input.puts "2,f\n"
    input.puts "3,f\n"
    input.puts "4,f\n"

    input.rewind
    ui = Ui.new(input, output, grid_display)
    game = Game.new(grid_display, ui, grid, player, ships_list, validations)
    game.start

    expect(output.string).to include("Congratulations Nicolò: YOU WON!")
  end

end
