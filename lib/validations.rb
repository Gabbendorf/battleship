class Validations

  def validate_ship_number(number)
    valid_options = [1, 2, 3, 4]
    if !valid_options.include?(number.to_i)
      :error
    end
  end

  def validate_position_for_ship(input)
    if !valid_coordinates_and_orientation?(split(input)[:orientation], split(input)[:letter], split(input)[:number])
      :error
    end
  end

  def check_ship_is_inside_grid(ship, input)
    if not_inside_grid?(split(input)[:orientation], ship.length, split(input)[:letter], split(input)[:number])
      :error
    end
  end

  def validate_position_to_attack(position)
    coordinates = position.split(",")
    number = coordinates[0]
    letter = coordinates[1]
    if !valid_number?(number) || !valid_letter?(letter)
      :error
    end
  end

  private

  def split(input)
    coordinates = input.split(",")
    {:number => coordinates[0],
     :letter => coordinates[1],
     :orientation => coordinates[2]
    }
  end

  def not_inside_grid?(orientation, ship_length, letter, number)
    invalid_vertically?(orientation, ship_length, letter) || invalid_horizontally?(orientation, ship_length, number)
  end

  def invalid_vertically?(orientation, ship_length, letter)
    orientation == "v" && number_for[letter] < ship_length
  end

  def invalid_horizontally?(orientation, ship_length, number)
    orientation == "h" && (number.to_i + ship_length-1) > 10
  end

  def number_for
    {"a" => 1,
     "b" => 2,
     "c" => 3,
    }
  end

  def valid_coordinates_and_orientation?(number, letter, orientation)
    valid_number?(number) && valid_letter?(letter) && valid_orientation?(orientation)
  end

  def valid_orientation?(orientation)
    orientation == "h" || orientation == "v"
  end

  def valid_number?(number)
    [1, 2, 3, 4, 5, 6, 7, 8, 9, 10].include?(number)
  end

  def valid_letter?(letter)
    ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j"].include?(letter)
  end

end
