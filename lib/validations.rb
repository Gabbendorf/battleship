class Validations

  def validate_ship_number(number)
    number = number.to_i
    valid_numbers = [1, 2, 3, 4]
    if !valid_numbers.include?(number)
      :error
    end
  end

  def validate_position_for_ship(position)
    splitted_position = position.split(",")
    if !valid_coordinates_and_orientation?(splitted_position)
      :error
    end
  end

  def check_ship_is_inside_grid(ship, position)
    position_details = position.split(",")
    orientation = position_details[2]
    if not_inside_grid?(orientation, ship, position_details)
      :error
    end
  end

  def validate_position_to_attack(position)
    coordinates = position.split(",")
    if !valid_number?(coordinates) || !valid_letter?(coordinates)
      :error
    end
  end

  private

  def not_inside_grid?(orientation, ship, position)
    invalid_vertically?(orientation, ship, position) || invalid_horizontally?(orientation, ship, position)
  end

  def invalid_vertically?(orientation, ship, position)
    orientation == "v" && number_for[position[1]] < ship.length
  end

  def invalid_horizontally?(orientation, ship, position)
    orientation == "h" && (position[0].to_i + ship.length-1) > 10
  end

  def number_for
    {"a" => 1,
     "b" => 2,
     "c" => 3,
    }
  end

  def valid_coordinates_and_orientation?(position)
    valid_number?(position) && valid_letter?(position) && valid_orientation?(position)
  end

  def valid_orientation?(position)
    position[2] == "h" || position[2] == "v"
  end

  def valid_number?(position)
    [1, 2, 3, 4, 5, 6, 7, 8, 9, 10].include?(position[0].to_i)
  end

  def valid_letter?(position)
    ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j"].include?(position[1])
  end

end
