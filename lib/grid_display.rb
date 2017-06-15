class GridDisplay

  attr_reader :grid

  def initialize
    @grid = [
              ["    ", 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, "\n"],
              ["A", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", "\n"],
              ["B", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", "\n"],
              ["C", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", "\n"],
              ["D", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", "\n"],
              ["E", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", "\n"],
              ["F", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", "\n"],
              ["G", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", "\n"],
              ["H", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", "\n"],
              ["I", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", "\n"],
              ["J", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", "\n"],
            ]
  end

  def prepare_grid
    @grid.join("   ")
  end

  def hit(position)
    row = position[1]
    column = position[0]
    @grid[number_of[row]][column] = "H"
  end

  def water(position)
    row = position[1]
    column = position[0]
    @grid[number_of[row]][column] = "W"
  end

  def sunk(ship_position)
    ship_position.each do |position|
      row = position[1]
      column = position[0]
      @grid[number_of[row]][column] = "S"
    end
  end

  def update_grid(result, cell_to_attack)
    if result == :hit
      hit(cell_to_attack)
    elsif result == :water
      water(cell_to_attack)
    end
  end

  private

  def number_of
    {"A" => 1,
     "B" => 2,
     "C" => 3,
     "D" => 4,
     "E" => 5,
     "F" => 6,
     "G" => 7,
     "H" => 8,
     "I" => 9,
     "J" => 10,
    }
  end

end
