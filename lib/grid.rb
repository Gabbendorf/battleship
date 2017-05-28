class Grid

  attr_reader :ships_placed

  def initialize
    @ships_placed = {}
  end

  # COLUMNS = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
  #
  # ROWS = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J"]

  # def cells
  #   cells = []
  #   COLUMNS.each do |number|
  #     cell = ""
  #     ROWS.each do |letter|
  #       cell += number.to_s
  #       cell += letter
  #       cells.push(cell)
  #       cell = ""
  #     end
  #   end
  #   cells
  # end
  #
  # def cell?(position)
  #   cells.include?(position)
  # end

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
