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

  def place_ship(start_position, ship)
      @ships_placed[ship] = [start_position]
  end

end
