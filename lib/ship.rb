require 'set'

class Ship

  attr_reader :name, :length

  def initialize(name, length)
    @name = name
    @length = length
    @cells_hit_set = Set.new
  end

  def hit?(attacked_cell,grid)
    occupied_cells(grid).include?(attacked_cell)
  end

  def register_cells_hit(attacked_cell,grid)
    if hit?(attacked_cell,grid)
      @cells_hit_set.add(attacked_cell)
    end
  end

  def occupied_cells(grid)
    grid.ships_placed[self]
  end

  def cells_hit
    @cells_hit_set.to_a
  end

  def sunk?
    @cells_hit_set.length == @length
  end

end
