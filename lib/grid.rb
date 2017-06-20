require_relative 'ship'

class Grid

  attr_reader :ships_placed, :ships_sunk_positions, :size

  def initialize(size)
    @size = size
    @ships_placed = []
    @ships_sunk_positions = []
  end

  def validate_placement(position, ship_length)
    if invalid_inputs?(position[:x], position[:y], position[:orientation]) == true
      :invalid_ship_position
    elsif ship_out_of_grid?( position[:x], position[:y], ship_length, position[:orientation]) == true
      :invalid_placement
    elsif already_occupied?(position) == true
      :already_occupied
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

  def show_result(attacked_cell)
    if ship?(attacked_cell)
      ship = ship_on(attacked_cell)
      ship.register_cells_hit(attacked_cell)
      result = :hit
      if ship.sunk?
        result = result_for_sunk(ship)
      end
    else
      result = :water
    end
    result
  end

  def register_sunk_ship_positions(ship)
    cells = ship.occupied_cells
    cells.each {|cell| @ships_sunk_positions.push(cell)}
  end

  def end_game?
    all_ships_positions = @ships_placed.map {|ship| ship.occupied_cells}
    all_ships_positions.flatten(1).length == @ships_sunk_positions.length
  end

  private

  def already_occupied?(position)
    position = [position[:x], position[:y]]
    occupied_positions = @ships_placed.map {|ship| ship.occupied_cells}
    occupied_positions.flatten(1).include?(position)
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
  end

  def result_for_sunk(ship)
    register_sunk_ship_positions(ship)
    :sunk
  end

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
