class ShipsList

  attr_reader :ships

  def initialize
    @ships = {#{"submarine" => 2,}
              "destroyer" => 2
              # "cruiser" => 1,
              # "aircraft-carrier" => 1
            }
  end

  def delete_selected_ship(ship_name)
    if @ships[ship_name] != 0
      @ships[ship_name] -= 1
      if @ships[ship_name] == 0
       @ships.delete(ship_name)
      end
    end
  end

  def convert_number_to_name(number)
    @ships.keys[number-1]
  end

end
