class Ship

  attr_reader :name, :length

  def initialize(name, length)
    @name = name
    @length = length
  end

  def hit?(attacked_cell,grid)
    occupied_cells(grid).include?(attacked_cell)
  end

  def occupied_cells(grid)
    grid.ships_placed[self]
  end

end
