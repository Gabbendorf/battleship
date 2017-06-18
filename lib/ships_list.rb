class ShipsList

  attr_reader :ships

  def initialize(create_ship)
    @create_ship = create_ship
    @ships = {"submarine" => 2,
              "destroyer" => 2,
              "cruiser" => 1,
              "aircraft-carrier" => 1
            }
  end

  def prepare_ship(ship_name)
    delete_selected_ship(ship_name)
    @create_ship.ship_from_name(ship_name)
  end

  def convert_number_to_name(number)
    @ships.keys[number-1]
  end

  def validate(number)
    valid_options = (1..@ships.size).map
    if !valid_options.include?(number.to_i)
      :invalid_ship_number
    else
      :valid_ship_number
    end
  end

  private

  def delete_selected_ship(ship_name)
    if @ships[ship_name] != 0
      @ships[ship_name] -= 1
      if @ships[ship_name] == 0
       @ships.delete(ship_name)
      end
    end
  end

end
