class Computer

  def initialize(grid, ships_list)
    @grid = grid
    @ships_list = ships_list
  end

  def select_randomly_ship
    @ships_list.ships.keys.sample
  end

  def select_random_position
    position = []
    position.push((1..10).map {|n| n}.sample)
    position.push(("A".."J").map {|n| n}.sample)
    position.push([:vertical, :horizontal].sample)
    position
  end

  # def place_ship(ship)
  #   @grid.mark_ship_positions
  # end
end
