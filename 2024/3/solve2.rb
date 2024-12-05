input = IO.read('input.txt')
result = 0
enabled = true

statements = input.scan(/do(?:n't)*\(\)|mul\([0-9]+,[0-9]+\)/)
statements.each do |statement|
  case statement
  when 'don\'t()'
    enabled = false
  when 'do()'
    enabled = true
  else
    numbers = statement.scan(/[0-9]+/).map(&:to_i)
    result += numbers[0] * numbers[1] if enabled
  end
end

puts result