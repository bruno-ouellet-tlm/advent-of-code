require 'matrix'

def is_inside?(map, position)
  position[0] >= 0 and position[1] >= 0 and position[0] < map.row_size and position[1] < map.column_size
end

DIRECTIONS = [[-1, 0], [0, 1], [1, 0], [0, -1]]
DIAGONALS = [[-1, 1], [1, 1], [1, -1], [-1, -1]]
DIAGONAL_ADJACENT_MAPPING = {
  DIAGONALS[0] => [DIRECTIONS[0], DIRECTIONS[1]],
  DIAGONALS[1] => [DIRECTIONS[1], DIRECTIONS[2]],
  DIAGONALS[2] => [DIRECTIONS[2], DIRECTIONS[3]],
  DIAGONALS[3] => [DIRECTIONS[3], DIRECTIONS[0]],
}

lines = IO.readlines('input.txt')
garden = Matrix.rows(lines.each.map {|line| line.strip.chars})

plots = {}

garden.each_with_index do |plant, row, col|
  plot_start = [row, col]
  next unless plots.select {|key, plot| plot.include? plot_start}.empty?

  plots[plot_start] = Set.new

  queue = [plot_start]
  next_queue = []
  steps = 0

  until queue.empty?
    queue.each do |position|
      x, y = position

      next unless garden.element(x, y) == plant

      next if plots[plot_start].include? position
      plots[plot_start] << position

      DIRECTIONS.each do |(dx, dy)|
        next_position = [x + dx, y + dy]

        next unless is_inside?(garden, next_position)

        next_queue << next_position
      end
    end
    queue, next_queue = next_queue, queue.clear
    steps += 1
  end
end

result = 0
plots.each do |key, plot|
  area = plot.size
  sides = 0

  plot.each do |(x, y)|
    DIAGONALS.each do | diagonal_position|
      dx, dy = diagonal_position
      diagonal = [x + dx, y + dy]
      first_adjacent = [x + DIAGONAL_ADJACENT_MAPPING[diagonal_position][0][0], y + DIAGONAL_ADJACENT_MAPPING[diagonal_position][0][1]]
      second_adjacent = [x + DIAGONAL_ADJACENT_MAPPING[diagonal_position][1][0], y + DIAGONAL_ADJACENT_MAPPING[diagonal_position][1][1]]

      is_diagonal_out = !(is_inside?(garden, diagonal) and plot.include?(diagonal))
      is_first_adjacent_out = !(is_inside?(garden, first_adjacent) and plot.include?(first_adjacent))
      is_second_adjacent_out = !(is_inside?(garden, second_adjacent) and plot.include?(second_adjacent))

      if (is_diagonal_out and is_first_adjacent_out and is_second_adjacent_out) ||
        (is_diagonal_out and !is_first_adjacent_out and !is_second_adjacent_out) ||
        (!is_diagonal_out and is_first_adjacent_out and is_second_adjacent_out)
        sides += 1
      end
    end
  end

  result += area * sides
end

puts result