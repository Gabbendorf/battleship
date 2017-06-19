class GridDisplay

  attr_reader :representation

  def initialize(grid_size)
    @grid_size = grid_size
    @representation = rows_and_columns
  end

  def prepare_grid
    @representation.join("   ")
  end

# Need to add :sunk as result and test
  def update_grid(result, cell_to_attack) #, grid)
    if result == :hit
      hit(cell_to_attack)
    elsif result == :water
      water(cell_to_attack)
    #elsif result == :sunk
    #   sunk_ship_positions = grid.ships_sunk_positions # => this should only return positions
      #sunk(sunk_ship_positions)
    end
  end

  def hit(position)
    row = position[1]
    column = position[0]
    @representation[number_of[row]][column] = "H"
  end

  def water(position)
    row = position[1]
    column = position[0]
    @representation[number_of[row]][column] = "W"
  end

  def sunk(ship_position)
    ship_position.each do |position|
      row = position[1]
      column = position[0]
      @representation[number_of[row]][column] = "S"
    end
  end

  private

  def rows_and_columns
    rows = [first_row]
    letters = ("A".."Z").take(@grid_size)
    letters.each do |letter|
      row = []
      row.push(letter)
      @grid_size.times do
        row.push(".")
      end
      row.push("\n")
      rows.push(row)
    end
    rows
  end

  def first_row
    first_row = ["    "]
    numbers = (1..@grid_size).to_a
    numbers.each {|number| first_row.push(number)}
    first_row.push("\n")
    first_row
  end

  def number_of
    letters = ("A".."Z").take(@grid_size)
    hash = {}
    number = 1
    letters.each do |letter|
      hash[letter] = number
      number += 1
    end
    hash
  end

end
