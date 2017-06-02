class Orientation

  def horizontal_cells(x,y, ship_length)
    occupied_cells = [[x,y]]
    (ship_length-1).times do
      x += 1
      occupied_cells.push([x,y])
    end
    occupied_cells
  end

end
