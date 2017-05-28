class Ship

  attr_reader :name, :length

  def initialize(name, length)
    @name = name
    @length = length
  end

  def hit?(attacked_cell,grid)
    ship_positions.each {|position| position == attacked_cell}
  end

  def position(grid)
    grid.ships_placed[self]
  end

end
