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

  def place_ship(x, y, ship)
    if ship.length == 1
      @ships_placed[ship] = [x,y]
    elsif ship.length == 2
      @ships_placed[ship] = [[x,y],[x+1,y]]
    elsif ship.length == 3
      @ships_placed[ship] = [[x,y],[x+1,y],[x+2,y]]
    elsif ship.length == 4
      @ships_placed[ship] = [[x,y],[x+1,y],[x+2,y],[x+3,y]]
    end
  end

end
