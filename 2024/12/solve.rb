require 'matrix'

def is_inside?(map, position)
  position[0] >= 0 and position[1] >= 0 and position[0] < map.row_size and position[1] < map.column_size
end

DIRECTIONS = [[-1, 0], [0, 1], [1, 0], [0, -1]]

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
  plant = garden.element(key[0], key[1])
  area = plot.size
  perimeter = 0

  plot.each do |(x, y)|
    DIRECTIONS.each do |(dx, dy)|
      nx, ny = [x + dx, y + dy]
      perimeter += 1 if !is_inside?(garden, [nx, ny]) or garden.element(nx, ny) != plant
    end
  end

  result += area * perimeter
end

puts result