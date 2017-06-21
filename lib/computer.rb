require_relative 'create_ship'
require_relative 'grid'
require_relative 'ships_list'
require_relative 'ship'
require_relative 'ships_placer'

class Computer < ShipsPlacer

  def initialize(grid, ships_list)
    @grid = grid
    @ships_list = ships_list
  end

  def ship_placement
    random_ship = generate_ship
    position = generate_position(select_random_position, random_ship.length)
    random_ship.register_position(position[:x], position[:y], position[:orientation])
    random_ship
  end

  private

  def generate_ship
    select_random_ship
  end

  def generate_position(position, ship_length)
    valid_position(position, ship_length)
  end

  # TODO: fix bug, looks like computer doesn't give valid position
  def valid_position(position, ship_length)
    validation_result = @grid.validate_placement(position, ship_length)
    while validation_result != :valid_position
      if validation_result == :invalid_placement || validation_result == :already_occupied
        position = select_random_position
        validation_result = @grid.validate_placement(position, ship_length)
      end
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
