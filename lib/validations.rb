class Validations

  def initialize(grid_display)
    @grid_display = grid_display
  end

  def validate_position_to_attack(input)
    if !valid_number?(input[0]) || !valid_letter?(input[1])
      :invalid_attack
    else
      :valid_attack
    end
  end

  private

  def valid_number?(number)
    @grid_display.grid[0].include?(number)
  end

  def valid_letter?(letter)
    @grid_display.grid.map {|array| array[0]}.include?(letter.capitalize)
  end
end
