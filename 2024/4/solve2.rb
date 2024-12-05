require 'matrix'

lines = IO.readlines('input.txt')
matrix = Matrix.rows(lines.each.map {|line| line.strip.chars})

result = 0

matrix.each_with_index do |letter, row, col|
  next if letter != 'A' || row < 1 || row >= matrix.row_size - 1 || col < 1 || col >= matrix.column_size - 1

  up_left = matrix.element(row - 1, col - 1)
  bottom_right = matrix.element(row + 1, col + 1)
  next unless up_left == 'M' && bottom_right == 'S' || up_left == 'S' && bottom_right == 'M'

  up_right = matrix.element(row + 1, col - 1)
  bottom_left = matrix.element(row - 1, col + 1)
  next unless up_right == 'M' && bottom_left == 'S' || up_right == 'S' && bottom_left == 'M'

  result += 1
end

puts result