require 'set'

class Ship

  attr_reader :name, :length

  def initialize(name, length)
    @name = name
    @length = length
    @cells_hit_set = Set.new
  end

  def register_cells_hit(attacked_cell)
    @cells_hit_set.add(attacked_cell)
  end

  def occupied_cells(grid)
    grid.ships_placed[self]
  end

  def cells_hit
    @cells_hit_set.to_a
  end

  def sunk?(grid)
    occupied_cells(grid).length == @cells_hit_set.length
  end

end
