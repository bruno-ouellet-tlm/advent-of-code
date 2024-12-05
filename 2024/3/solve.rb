input = IO.read('input.txt')
result = 0

statements = input.scan(/mul\([0-9]+,[0-9]+\)/)
statements.each do |statement|
  numbers = statement.scan(/[0-9]+/).map(&:to_i)
  result += numbers[0] * numbers[1]
end

puts result