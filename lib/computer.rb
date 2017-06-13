class Computer

  def initialize(grid, ships_list)
    @grid = grid
    @ships_list = ships_list
    @create_ship = CreateShip.new
  end

  def place_ship(x, y, ship, orientation)
    while @ships_list.ships.size > 0
      random_ship_name = select_randomly_ship
      position = select_random_position
      ship = @create_ship.ship_from_name(random_ship_name)
      @grid.mark_ship_positions(position[0], position[1], ship, position[2])
      @ships_list.delete_selected_ship(random_ship_name)
    end
  end

  def select_randomly_ship
    @ships_list.ships.keys.sample
  end

  def select_random_position
    position = []
    position.push((1..10).map {|number| number}.sample)
    position.push(("A".."J").map {|letter| letter}.sample)
    position.push([:vertical, :horizontal].sample)
    position
  end

end
