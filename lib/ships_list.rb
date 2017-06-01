class ShipsList

  attr_reader :ships

  def initialize
    @ships = {1 => 2,
              2 => 2,
              3 => 1,
              4 => 1}
  end

  def delete_selected_ship(number)
    if @ships[number] != 0
      @ships[number] -= 1
    end
    if @ships[number] == 0
      @ships.delete(number)
    end
    @ships
  end

  public

  def convert_number_to_name(number)
    case number
    when 1
      "submarine"
    when 2
      "destroyer"
    when 3
      "cruiser"
    when 4
      "aircraft-carrier"
    end
  end

end
