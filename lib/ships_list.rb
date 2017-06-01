class ShipsList

  attr_reader :ships

  def initialize
    @ships = {"submarine" => 2,
              "destroyer" => 2,
              "cruiser" => 1,
              "aircraft-carrier" => 1}
  end

  def delete_selected_ship(ship_name)
    if @ships[ship_name] != 0
      @ships[ship_name] -= 1
    end
    if @ships[ship_name] == 0
      @ships.delete(ship_name)
    end
    @ships
  end

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
