lists = [[], []]
lines = IO.readlines('input.txt')

lines.each do |line|
  numbers = line.split.map(&:to_i)
  lists.each_with_index {|list, index| list << numbers[index] }
end

lists = lists.map(&:sort)

result = 0
similarity = 0
lists[0].each_index do |index|
  result += (lists[0][index] - lists[1][index]).abs
  similarity += lists[0][index] * lists[1].count(lists[0][index])
end

puts result
puts similarity