require 'matrix'

def walk_trail(x, y, map, end_positions)
  position = map.element(x, y)
  next_position = position + 1

  if position == 9
    end_positions << [x, y]
    nil
  end

  if x > 0 and map.element(x - 1, y) == next_position
    walk_trail(x - 1, y, map, end_positions)
  end

  if y > 0 and map.element(x, y - 1) == next_position
    walk_trail(x, y - 1, map, end_positions)
  end

  if x < map.row_size - 1 and map.element(x + 1, y) == next_position
    walk_trail(x + 1, y, map, end_positions)
  end

  if y < map.column_size - 1 and map.element(x, y + 1) == next_position
    walk_trail(x, y + 1, map, end_positions)
  end
end

lines = IO.readlines('input.txt')
map = Matrix.rows(lines.each.map {|line| line.strip.chars.map(&:to_i)})
total_score = 0

map.each_with_index do |position, row, col|
  next unless position == 0

  end_positions = Set.new
  walk_trail(row, col, map, end_positions)
  total_score += end_positions.count
end

puts total_score