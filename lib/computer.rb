class Computer

  def initialize(grid, ships_list, validations)
    @grid = grid
    @ships_list = ships_list
    @validations = validations
    @create_ship = CreateShip.new
  end

  def place_ship
    while @ships_list.ships.size > 0
      random_ship = select_randomly_ship
      position = valid_position(random_ship, select_random_position)
      @grid.mark_ship_positions(position[:x], position[:y], random_ship, position[:orientation])
    end
  end

  private

  def valid_position(ship, position)
    validation_result = @validations.validate_position_for_ship(ship, position)
    while validation_result != :valid_ship_position
      if validation_result == :invalid_ship_position || validation_result == :invalid_placement
        position = select_random_position
      end
      validation_result = @validations.validate_position_for_ship(ship, position)
    end
    position
  end

  def select_randomly_ship
    random_ship_name = @ships_list.ships.keys.sample
    ship = @create_ship.ship_from_name(random_ship_name)
    @ships_list.delete_selected_ship(random_ship_name)
    ship
  end

  def select_random_position
    position = {}
    position[:x] = rand(1..10)
    position[:y] = (("A".."J").map {|letter| letter}.sample)
    position[:orientation] = ([:vertical, :horizontal].sample)
    position
  end

end
