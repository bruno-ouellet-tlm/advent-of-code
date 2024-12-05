require 'matrix'

def search_word(matrix, row, col, direction)
  dx = direction[0]
  dy = direction[1]

  "XMAS".chars.each_with_index do |x, k|
    ii = row + k * dx
    jj = col + k * dy

    unless (0 <= ii and ii < matrix.row_size) and (0 <= jj and jj < matrix.column_size)
      return false
    end
    unless matrix.element(ii, jj) == x
      return false
    end
  end

  true
end

DIRECTIONS = [
  [1, 0],
  [-1, 0],
  [0, -1],
  [0, 1],
  [-1, -1],
  [-1, 1],
  [1, -1],
  [1, 1],
]

lines = IO.readlines('input.txt')
matrix = Matrix.rows(lines.each.map {|line| line.strip.chars})

result = 0

matrix.each_with_index do |letter, row, col|
  next unless letter == 'X'

  DIRECTIONS.each do |direction|
    result += 1 if search_word(matrix, row, col, direction)
  end
end

puts result