class Grid

  attr_reader :ships_placed

  def initialize
    @ships_placed = {}
  end

  def place_ship(x,y,ship)
    if ship.length == 1
      @ships_placed[ship] = x,y
    else
      @ships_placed[ship] = next_cells_horizontally(x,y,ship.length).insert(0,[x,y])
    end
  end

  def next_cells_horizontally(x,y, ship_length)
    next_cells = []
    (ship_length-1).times do
      x += 1
      next_cells.push([x,y])
    end
    next_cells
  end

end
