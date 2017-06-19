require_relative 'ship'

class Grid

  attr_reader :ships_placed, :ships_sunk, :size

  def initialize(size)
    @size = size
    @ships_placed = []
    @ships_sunk = []
  end

  def validate_placement(position, ship_length)
    if invalid_inputs?(position[:x], position[:y], position[:orientation]) == true
      :invalid_ship_position
    elsif ship_out_of_grid?( position[:x], position[:y], ship_length, position[:orientation]) == true
      :invalid_placement
    else
      :valid_position
    end
  end

  def position_in_grid?(x, y)
    columns.include?(x) && rows.include?(y)
  end

  def add_ship(ship)
    @ships_placed.push(ship)
  end

  def ship?(position)
    all_occupied_cells = @ships_placed.map {|ship| ship.occupied_cells}
    all_occupied_cells.flatten(1).include?(position)
  end

  def ship_on(position)
    @ships_placed.each do |ship|
      if ship.occupied_cells.include?(position)
        return ship
      end
    end
    nil
  end

  def register_sunk_ship(ship)
      @ships_sunk.push(ship)
  end

  def end_game?
    @ships_placed.length == @ships_sunk.length
  end

  private

  def ship_out_of_grid?(x, y, ship_length, orientation)
    orientation == :horizontal ?
    invalid_horizontally?(x, ship_length) : invalid_vertically?(y, ship_length)
  end

  def invalid_inputs?(x, y, orientation)
    !position_in_grid?(x, y) || !valid_orientation?(orientation)
  end

  def invalid_vertically?(y, ship_length)
    (number_for_letter(y) + (ship_length - 1)) > 10
  end

  def invalid_horizontally?(x, ship_length)
    (x.to_i + ship_length - 1) > 10
  end

  def number_for_letter(y)
    rows.index(y) + 1
  end

  def columns
    (1..@size).map {|number| number}
  end

  def rows
    ("A".."Z").take(@size)
  end

  def valid_orientation?(orientation)
    orientation == :vertical || orientation == :horizontal
  end

end
