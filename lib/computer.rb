require_relative 'create_ship'
require_relative 'grid'
require_relative 'ships_list'
require_relative 'ship'

class Computer

  def initialize(grid, ships_list)
    @grid = grid
    @ships_list = ships_list
    @create_ship = CreateShip.new
  end

  def place_ship
    while @ships_list.ships.size > 0
      random_ship = select_random_ship
      position = valid_position(select_random_position, random_ship.length)
      random_ship.register_position(position[:x], position[:y], position[:orientation])
      @grid.add_ship(random_ship)
    end
  end

  private

  def valid_position(position, ship_length)
    validation_result = @grid.validate_placement(position, ship_length)
    while validation_result != :valid_position
      if validation_result == :invalid_placement
        position = select_random_position
      end
      validation_result = @grid.validate_placement(position, ship_length)
    end
    position
  end

  def select_random_ship
    random_ship_name = @ships_list.ships.keys.sample
    @ships_list.prepare_ship(random_ship_name)
  end

  def select_random_position
    position = {}
    position[:x] = rand(1..10)
    position[:y] = (("A".."J").map {|letter| letter}.sample)
    position[:orientation] = ([:vertical, :horizontal].sample)
    position
  end

end
