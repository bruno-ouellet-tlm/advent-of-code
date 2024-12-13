require 'matrix'

def is_inside?(map, position)
  position[0] >= 0 and position[1] >= 0 and position[0] < map.row_size and position[1] < map.column_size
end

lines = IO.readlines('input.txt')
city = Matrix.rows(lines.each.map {|line| line.strip.chars})

antennas_map = {}

city.each_with_index do |position, row, col|
  unless position == '.'
    if antennas_map[position].nil?
      antennas_map[position] = [[row, col]]
    else
      antennas_map[position] << [row, col]
    end
  end
end

antinodes = antennas_map.each.with_object(Set.new) do |antennas, nodes|
  antennas[1].permutation(2).each do |a, b|
    (0..).each do |i|
      ax, ay = a
      bx, by = b

      diff_ax = ax - bx
      diff_ay = ay - by

      diff_bx = bx - ax
      diff_by = by - ay

      antinode_a = [ax + (i * diff_bx), ay + (i * diff_by)]
      antinode_b = [bx + (i * diff_ax), by + (i * diff_ay)]
      break unless is_inside?(city, antinode_a) or is_inside?(city, antinode_b)
      nodes << antinode_a if is_inside?(city, antinode_a)
      nodes << antinode_b if is_inside?(city, antinode_b)
    end
  end
end

puts antinodes.size

