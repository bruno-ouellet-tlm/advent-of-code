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

def next_step(lab, position, direction_idx, obstructed_position)
  next_position = next_position(position, DIRECTIONS[direction_idx])
  while is_wall?(lab, next_position) or next_position == obstructed_position
    direction_idx = (direction_idx + 1) % 4
    next_position = next_position(position, DIRECTIONS[direction_idx])
  end

  [next_position, direction_idx]
end

def follow_path(lab, position, obstructed_position = nil)
  visited = Set.new
  direction_index = 0

  while is_inside?(lab, position)
    return false if !obstructed_position.nil? and visited.include?([position, direction_index])
    visited << [position, direction_index]
    position, direction_index = next_step(lab, position, direction_index, obstructed_position)
  end

  visited.map(&:first).uniq
end

lines = IO.readlines('input.txt')
laboratory = Matrix.rows(lines.each.map {|line| line.strip.chars})

guard_position = laboratory.index "^"

DIRECTIONS = [[-1, 0], [0, 1], [1, 0], [0, -1]]

visited_positions = follow_path(laboratory, guard_position.dup)

possible_obstructions = visited_positions.select do |obstructed_position|
  false if obstructed_position == guard_position
  follow_path(laboratory, guard_position, obstructed_position) == false
end

puts possible_obstructions.count
