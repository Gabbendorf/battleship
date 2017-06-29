require 'set'
require_relative 'orientation'

class Ship

  attr_reader :name, :length, :occupied_cells

  def initialize(name, length)
    @name = name
    @length = length
    @occupied_cells = []
    @cells_hit_set = Set.new
  end

  def register_position(x, y, orientation)
    all_cells(x, y, @length, orientation).each {|array| @occupied_cells.push(array)}
  end

  def register_cells_hit(attacked_cell)
    @cells_hit_set.add(attacked_cell)
  end

  def cells_hit
    @cells_hit_set.to_a
  end

  def sunk?
    @cells_hit_set.length == @length
  end

  private

  def all_cells(x, y, length, orientation)
    if orientation == :horizontal
      Orientation.new.horizontal_cells(x, y, length)
    elsif orientation == :vertical
      Orientation.new.vertical_cells(x, y, length)
    end
  end

end
