class Orientation

  def horizontal_cells(x, y, ship_length)
    occupied_cells = [[x, y]]
    (ship_length-1).times do
      x += 1
      occupied_cells.push([x,y])
    end
    occupied_cells
  end

  def vertical_cells(x, y, ship_length)
    occupied_cells = [[x, y]]
    letters_after = (y.."Z").map {|letter| letter}
    (ship_length-1).times do |index|
      next_letter = letters_after[index+1]
      occupied_cells.push([x,next_letter])
    end
    occupied_cells
  end

end
