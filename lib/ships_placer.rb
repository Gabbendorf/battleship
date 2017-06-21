class ShipsPlacer

  def ship_placement
    ship = generate_ship
    position = generate_position(ship)
    ship.register_position(position[:x], position[:y], position[:orientation])
    ship
  end

  private

  def generate_ship

  end

  def generate_position(ship)

  end

end
