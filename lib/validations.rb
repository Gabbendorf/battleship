class Validations

  def validate_ship_number(number)
    number = number.to_i
    valid_numbers = [1, 2, 3, 4]
    if !valid_numbers.include?(number)
      :error
    end
  end

  def validate_ship_to_place_position(position)
    splitted_position = position.split(",")
    if !valid_coordinates_and_orientation?(splitted_position)
      :error
    end
  end

  def validate_ship_position_on_grid(ship, position)
    splitted_position = position.split(",")
    if splitted_position[2] == "v" && number_for[splitted_position[1]] < ship.length || splitted_position[2] == "h" && (splitted_position[0].to_i + ship.length-1) > 10
      :error
    end
  end

  private

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
