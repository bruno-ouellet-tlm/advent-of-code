require 'matrix'

def walk_trail(x, y, map)
  position = map.element(x, y)
  next_position = position + 1

  if position == 9
    return 1
  end

  score = 0
  if x > 0 and map.element(x - 1, y) == next_position
    score += walk_trail(x - 1, y, map)
  end

  if y > 0 and map.element(x, y - 1) == next_position
    score += walk_trail(x, y - 1, map)
  end

  if x < map.row_size - 1 and map.element(x + 1, y) == next_position
    score += walk_trail(x + 1, y, map)
  end

  if y < map.column_size - 1 and map.element(x, y + 1) == next_position
    score += walk_trail(x, y + 1, map)
  end

  score
end

lines = IO.readlines('input.txt')
map = Matrix.rows(lines.each.map {|line| line.strip.chars.map(&:to_i)})
total_score = 0

map.each_with_index do |position, row, col|
  next unless position == 0

  total_score += walk_trail(row, col, map)
end

puts total_score