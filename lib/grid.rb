require_relative 'ship'

class Grid

  attr_reader :ships_placed, :ships_sunk, :size

  def initialize(size)
    @size = size
    @ships_placed = {}
    @ships_sunk = []
  end

  def validate_position(position, ship_length)
    if invalid_position_for_ship?(position[:x], position[:y], position[:orientation]) == true
      :invalid_ship_position
    elsif ship_out_of_grid?( position[:x], position[:y], ship_length, position[:orientation]) == true
      :invalid_placement
    else
      :valid_position
    end
  end

  def mark_ship_positions(x, y, ship, orientation)
    ship.register_position(x, y, orientation)
    @ships_placed[ship] = ship.occupied_cells
  end

  def ship?(position)
     all_occupied_cells = @ships_placed.values.inject {|sum,array| sum + array}
     all_occupied_cells.include?(position)
  end

  def ship_on(position)
    @ships_placed.each do |key, value|
      if value.include?(position)
        return key
      end
    end
    nil
  end

  def add_sunk_ship(ship)
    if ship.sunk?
      @ships_sunk.push(ship)
    end
  end

  def end_game?
    @ships_placed.length == @ships_sunk.length
  end

  private

  def invalid_position_for_ship?(x, y, orientation)
    if invalid_inputs?(x, y, orientation)
      true
    else
      false
    end
  end

  def ship_out_of_grid?(x, y, ship_length, orientation)
    orientation == :horizontal ?
    invalid_horizontally?(x, ship_length) : invalid_vertically?(y, ship_length)
  end

  def invalid_inputs?(x, y, orientation)
    !columns.include?(x) || !rows.include?(y) || !valid_orientation?(orientation)
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
    ("a".."z").take(@size)
  end

  def valid_orientation?(orientation)
    orientation == :vertical || orientation == :horizontal
  end

end
