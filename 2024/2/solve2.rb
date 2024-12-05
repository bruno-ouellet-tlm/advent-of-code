def is_safe?(n)
  (n == n.sort || n == n.sort.reverse) && n.each_cons(2).all? {|a, b| (a - b).abs >= 1 && (a - b).abs <= 3}
end

lines = IO.readlines('input.txt')
result = 0

lines.each do |line|
  numbers = line.split.map(&:to_i)

  if is_safe? numbers
    result += 1
  else
    numbers.combination(numbers.length - 1).each do |permutation|
      if is_safe? permutation
        result += 1
        break
      end
    end
  end
end

puts result