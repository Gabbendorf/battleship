class Validations

  def initialize(grid_display)
    @grid_display = grid_display
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
    if !valid_number?(input[0]) || !valid_letter?(input[1])
      :invalid_attack
    else
      :valid_attack
    end
  end

  private

  def not_inside_grid?(orientation, ship_length, letter, number)
    orientation == :horizontal ? invalid_horizontally?(ship_length, number) : invalid_vertically?(ship_length, letter)
  end

  def invalid_vertically?(ship_length, letter)
    (@grid_display.number_of[letter.upcase] + (ship_length-1)) > 10
  end

  def invalid_horizontally?(ship_length, number)
    (number.to_i + ship_length-1) > 10
  end

  def invalid_position?(number, letter, orientation)
    !valid_number?(number) || !valid_letter?(letter) || !valid_orientation?(orientation)
  end

  def valid_orientation?(orientation)
    orientation == :horizontal || orientation == :vertical
  end

  def valid_number?(number)
    @grid_display.grid[0].include?(number)
  end

  def valid_letter?(letter)
    @grid_display.grid.map {|array| array[0]}.include?(letter.capitalize)
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
