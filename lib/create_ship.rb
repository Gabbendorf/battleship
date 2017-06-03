class CreateShip

  def ship_from_name(ship_name)
    case ship_name
    when "submarine"
      Ship.new("submarine", 1)
    when "destroyer"
      Ship.new("destroyer", 2)
    when "cruiser"
      Ship.new("cruiser", 3)
    when "aircraft-carrier"
      Ship.new("aircraft-carrier", 4)
    end
  end

end
