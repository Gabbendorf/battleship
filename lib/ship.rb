class Ship

  attr_reader :name, :length, :cells_hit

  def initialize(name, length)
    @name = name
    @length = length
    @cells_hit = []
  end

  def hit?(attacked_cell,grid)
    occupied_cells(grid).include?(attacked_cell)
  end

  def register_cells_hit(attacked_cell,grid)
    if hit?(attacked_cell,grid)
      @cells_hit.push(attacked_cell)
    end
  end

  def occupied_cells(grid)
    grid.ships_placed[self]
  end

  def sunk?
    @cells_hit.length == @length
  end

end
