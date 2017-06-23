require_relative 'create_ship'
require_relative 'grid'
require_relative 'ships_list'
require_relative 'ship'

class Computer

  def initialize(grid, ships_list)
    @grid = grid
    @ships_list = ships_list
  end

  def ship_placement
    random_ship = generate_ship
    position = generate_position(random_ship.length)
    random_ship.register_position(position[:x], position[:y], position[:orientation])
    random_ship
  end

  private

  def generate_ship
    select_random_ship
  end

  def generate_position(ship_length)
    valid_position(ship_length)
  end

  def valid_position(ship_length)
    random_position = select_random_position
    validation_result = @grid.validate_placement(random_position, ship_length)
    while validation_result != :valid_position
      random_position = select_random_position
      validation_result = @grid.validate_placement(random_position, ship_length)
    end
    random_position
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
