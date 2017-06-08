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
    if !valid_numbers_for_columns.include?(splitted_position[0].to_i) || !valid_letters_for_rows.include?(splitted_position[1]) || splitted_position[3] != "v" || splitted_position[3] != "h"
      :error
    end
  end

  private

  def valid_numbers_for_columns
    [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
  end

  def valid_letters_for_rows
    ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j"]
  end

end
