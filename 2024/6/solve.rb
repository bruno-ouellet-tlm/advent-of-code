require 'matrix'
require 'set'

def is_inside?(lab, position)
  position[0] >= 0 and position[1] >= 0 and position[0] < lab.row_size and position[1] < lab.column_size
end

def is_wall?(lab, position)
  is_inside?(lab, position) and lab.element(position[0], position[1]) == '#'
end

def next_position(position, direction)
  [position[0] + direction[0], position[1] + direction[1]]
end

def next_step(lab, position, direction_idx)
  next_position = next_position(position, DIRECTIONS[direction_idx])
  while is_wall?(lab, next_position)
    direction_idx = (direction_idx + 1) % 4
    next_position = next_position(position, DIRECTIONS[direction_idx])
  end

  [next_position, direction_idx]
end

lines = IO.readlines('input.txt')
laboratory = Matrix.rows(lines.each.map {|line| line.strip.chars})

guard_position = laboratory.index "^"
DIRECTIONS = [[-1, 0], [0, 1], [1, 0], [0, -1]]
direction_index = 0
visited = Set.new

while is_inside?(laboratory, guard_position)
  visited << guard_position
  guard_position, direction_index = next_step(laboratory, guard_position, direction_index)
end

puts visited.count