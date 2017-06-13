class Computer

  def initialize(grid, ships_list)
    @grid = grid
    @ships_list = ships_list
    @create_ship = CreateShip.new
  end

  def place_ship(x, y, ship, orientation)
    while @ships_list.ships.size > 0
      random_ship = select_randomly_ship
      position = select_random_position
      @grid.mark_ship_positions(position[0], position[1], random_ship, position[2])
    end
  end

  private

  def select_randomly_ship
    random_ship_name = @ships_list.ships.keys.sample
    ship = @create_ship.ship_from_name(random_ship_name)
    @ships_list.delete_selected_ship(random_ship_name)
    ship
  end

  def select_random_position
    position = []
    position.push(rand(1..10))
    position.push(("A".."J").map {|letter| letter}.sample)
    position.push([:vertical, :horizontal].sample)
    position
  end

end
