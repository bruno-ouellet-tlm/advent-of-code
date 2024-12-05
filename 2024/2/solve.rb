def is_safe?(n)
  (n == n.sort || n == n.sort.reverse) && n.each_cons(2).all? {|a, b| (a - b).abs >= 1 && (a - b).abs <= 3}
end

lines = IO.readlines('input.txt')
result = 0

lines.each do |line|
  numbers = line.split.map(&:to_i)
  result += 1 if is_safe? numbers
end

puts result