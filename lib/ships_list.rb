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
  end

  def convert_number_to_name(number)
    case number
    when 1
      @ships.keys[0]
    when 2
      @ships.keys[1]
    when 3
      @ships.keys[2]
    when 4
      @ships.keys[3]
    end
  end

end
