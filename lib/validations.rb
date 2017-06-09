class Validations

  def validate_ship_number(number)
    valid_options = [1, 2, 3, 4]
    if !valid_options.include?(number.to_i)
      :error
    end
  end

  def validate_position_for_ship(input)
    if input_validity(split(input)[:number], split(input)[:letter], split(input)[:orientation]) == :invalid_input
      :error
    end
  end

  def check_ship_is_inside_grid(ship, input)
    if not_inside_grid?(split(input)[:orientation], ship.length, split(input)[:letter], split(input)[:number])
      :error
    end
  end

  def validate_position_to_attack(input)
    if !valid_number?(split(input)[:number]) || !valid_letter?(split(input)[:letter])
      :error
    end
  end

  private

  def split(input)
    details = input.split(",")
    {:number => details[0].to_i,
     :letter => details[1],
     :orientation => details[2]
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

  def input_validity(number, letter, orientation)
    if !valid_number?(number) || !valid_letter?(letter) || !valid_orientation?(orientation)
      return :invalid_input
    elsif valid_number?(number) && valid_letter?(letter) && valid_orientation?(orientation)
      return :valid_input
    end
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
