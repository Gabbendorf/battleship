class Grid

  attr_reader :ships_placed

  def initialize
    @ships_placed = {}
  end

  def list_of_ships
    {'submarine' => 2,
     'destroyer' => 2,
     'cruise' => 1,
     'aircraft-carrier' => 1}
  end

  def place_ship(x,y,ship)
    @ships_placed[ship] = occupied_cells(x,y,ship.length)
  end

  def occupied_cells(x,y, ship_length)
    occupied_cells = [[x,y]]
    (ship_length-1).times do
      x += 1
      occupied_cells.push([x,y])
    end
    occupied_cells
  end

  def ship?(position)
     all_occupied_cells = @ships_placed.values.inject {|sum,array| sum + array}
     all_occupied_cells.include?(position)
  end

end
