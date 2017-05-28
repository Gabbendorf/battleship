class Grid

  attr_reader :ships_placed

  def initialize
    @ships_placed = {}
  end

  def place_ship(x,y,ship)
    @ships_placed[ship] = occupied_cells(x,y,ship.length)
  end

  private

  def occupied_cells(x,y, ship_length)
    occupied_cells = [[x,y]]
    (ship_length-1).times do
      x += 1
      occupied_cells.push([x,y])
    end
    occupied_cells
  end

end
