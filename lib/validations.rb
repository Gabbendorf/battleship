class Validations

  def validate_ship_number(number)
    valid_options = [1, 2, 3, 4]
    if !valid_options.include?(number.to_i)
      :invalid_ship_number
    else
      :valid_ship_number
    end
  end

  def validate_position_for_ship(ship, input)
    if validate_position(input) == :invalid_ship_position
      :invalid_ship_position
    elsif check_ship_is_inside_grid(ship, input) == :invalid_placement
      :invalid_placement
    else
      :valid_ship_position
    end
  end

  def validate_position_to_attack(input)
    if !valid_number?(split(input)[:number]) || !valid_letter?(split(input)[:letter])
      :invalid_attack
    else
      :valid_attack
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
    orientation == :horizontal ? invalid_horizontally?(ship_length, number) : invalid_vertically?(ship_length, letter)
  end

  def invalid_vertically?(ship_length, letter)
    (number_for[letter.downcase] + (ship_length-1)) > 10
  end

  def invalid_horizontally?(ship_length, number)
    (number.to_i + ship_length-1) > 10
  end

  def number_for
    {"a" => 1,
     "b" => 2,
     "c" => 3,
     "d" => 4,
     "e" => 5,
     "f" => 6,
     "g" => 7,
     "h" => 8,
     "i" => 9,
     "j" => 10
    }
  end

  def invalid_position?(number, letter, orientation)
    !valid_number?(number) || !valid_letter?(letter) || !valid_orientation?(orientation)
  end

  def valid_orientation?(orientation)
    orientation == :horizontal || orientation == :vertical
  end

  def valid_number?(number)
    [1, 2, 3, 4, 5, 6, 7, 8, 9, 10].include?(number)
  end

  def valid_letter?(letter)
    ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j"].include?(letter.downcase)
  end

  def validate_position(input)
    if invalid_position?(input[:x], input[:y], input[:orientation])
      :invalid_ship_position
    else
      :valid_ship_position
    end
  end

  def check_ship_is_inside_grid(ship, input)
    if not_inside_grid?(input[:orientation], ship.length, input[:y].downcase, input[:x])
      :invalid_placement
    else
      :valid_placement
    end
  end

end
