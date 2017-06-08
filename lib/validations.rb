class Validations

  def validate_ship_number(number)
    number = number.to_i
    valid_numbers = [1, 2, 3, 4]
    if !valid_numbers.include?(number)
      :error
    end
  end

end
