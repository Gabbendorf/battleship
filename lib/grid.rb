require_relative 'orientation'
require_relative 'ship'

class Grid

  attr_reader :ships_placed, :ships_sunk

  def initialize
    @ships_placed = {}
    @ships_sunk = []
  end

  def mark_ship_positions(x, y, ship, orientation)
    @ships_placed[ship] = occupied_cells(x, y, ship.length, orientation)
  end

  def occupied_cells(x, y, ship_length, orientation)
    if orientation == "horizontal"
      Orientation.new.horizontal_cells(x, y, ship_length)
    elsif orientation == "vertical"
      Orientation.new.vertical_cells(x, y, ship_length)
    end
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

  # def declare_winner
  #   if @ships_placed.length == @ships_sunk
  #     :winner
  #   end
  # end

end
